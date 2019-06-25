//
//  DataManager.swift
//  PetProject Debug Client
//
//  Created by Zaccari Silverman on 5/9/19.
//  Copyright © 2019 macosten. All rights reserved.
//

import PromiseKit

enum RequestType : String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum AuthType {
    case none
    case token
    case basic
//  case oauth2
}

struct BasicAuthCredentials {
    let username: String
    let password: String
}

struct NilRequest : Codable {
    init?(){
        return nil
    }
}

//Get requests retrieve data and do not modify anything on the server.

//Post requests send data to the server to create or update something.
//Sending the same post request multiple times may produce different results.

//Put requests are like idempotent Post requests.
//Sending the same Put request multiple times will not produce a different result from sending it once.

//Delete requests delete something from the server.

final class RequestManager: NSObject {
    
    //MARK - General Request Method
    static let defaultServerAddress : String = "http://localhost:8080/api/"
    
    //Sends a request of type requestType to the path specified by urlString. If authToken is specified, it is used. If jsonBody is specified, it will be attached to the request.
    //The server's JSON response is returned as a Data promise. The method calling this one must do the decoding.
    static fileprivate func sendRequest<T: Encodable>(_ requestType: RequestType, authType: AuthType = .token, basicAuthCredentials: BasicAuthCredentials? = nil, urlString: String, jsonBody: T?) -> Promise<Data> {
        
        return Promise { seal in
            //Attempt to create the URL. If it fails, fail the promise.
            guard let url = URL(string: urlString) else {
                seal.reject(NSError(domain: "sendRequest", code: 1, userInfo: [NSLocalizedDescriptionKey: "An error ocurred when creating a URL from the string: \"\(urlString)\"."]))
                return
            }
            //Now, create and set the type of the request
            var request = URLRequest(url: url)
            request.httpMethod = requestType.rawValue
            
            //Now, if we're using basic auth instead of token auth, let's set the appropriate headers here.
            switch authType {
            case .basic:
                guard let credentials = basicAuthCredentials else {
                    seal.reject(NSError(domain: "sendRequest", code: -1, userInfo: [NSLocalizedDescriptionKey: "A basic header auth request was attempted, but no basic auth credentials were given to the method. This indicates a bug."]))
                    return
                }
                //The correct header is "Basic: Username:Password" with "Username:Password in base64 encoding.
                let authString = "\(credentials.username):\(credentials.password)"
                request.setValue("Basic \(Data(authString.utf8).base64EncodedString())", forHTTPHeaderField: "Authorization")
            case .token:
                //Use the authentication token, if present.
                if let authToken = KeychainManager.token {
                    request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
                }
            case .none:
                break //Don't mess with the headers if we're not using any authentication.
            }
            
            //Use the JSON body, if present.
            if jsonBody != nil {
                request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
                request.httpBody = try JSONEncoder().encode(jsonBody)
            }
            
            //Begin and execute the request.
            let dataPromise = URLSession.shared.dataTask(.promise, with: request)
            dataPromise.done{ data, urlResponse in
                    //If successful, fulfill the seal with the returned data.
                    seal.fulfill(data)
            }.catch { error in
                    //This will happen if dataPromise.done{} throws itself. I'm not sure why this would happen, but it might.
                    seal.reject(NSError(domain: "sendPostRequest", code: 4, userInfo: [NSLocalizedDescriptionKey: "dataPromise threw an error: \(error.localizedDescription)"]))
                    return
            }
        }
    }
    
    //MARK - Specific Request Methods
    //MARK - Login and Logout
    
    static let loginUrlString : String = RequestManager.defaultServerAddress + "auth/login/"
    
    static func createUser(createUserRequest: CreateUserRequest) -> Promise<Status> {
        return sendRequest(.post, urlString: RequestManager.defaultServerAddress + "auth/register/", jsonBody: createUserRequest).map { data in
            //The server will return a Status object, so we'll decode it. If it fails, it'll error out.
            return try JSONDecoder().decode(Status.self, from: data)
            
        }
    }
    
    static func userLogin(basicAuthCredentials: BasicAuthCredentials) -> Promise<String> {
        //Encode the object, then send the request. If the encoding fails, return a rejected promise.
        //Note that this will use basic auth.
        return sendRequest(.post, authType: .basic, basicAuthCredentials: basicAuthCredentials, urlString: loginUrlString, jsonBody: NilRequest()).map { data in
            return try JSONDecoder().decode(WrappedUserAccessToken.self, from: data).access_token
        }
        
    }
    
    static func userLogout(username: String, password: String) -> Promise<Status> {
        //The server will know who is logging out based on the token sent.
        return sendRequest(.delete, urlString: loginUrlString, jsonBody: NilRequest()).map { data in
            //The server will return a Status object, so we'll decode it. If it fails, it'll error out.
            return try JSONDecoder().decode(Status.self, from: data)
            
        }
        
    }
    
    
    
}
