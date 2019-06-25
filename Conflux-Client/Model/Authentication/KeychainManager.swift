//
//  TokenManager.swift
//  PetProject Debug Client
//
//  Created by Zaccari Silverman on 5/20/19.
//  Copyright © 2019 macosten. All rights reserved.
//

import Foundation
import KeychainAccess

final class KeychainManager: NSObject {
    
    private static let accessGroup = "Conflux" //Not final
    private static let serviceName = "Conflux-iOS-Devel"
    
    static let keychain = Keychain(service: KeychainManager.serviceName, accessGroup: KeychainManager.accessGroup)
    
    static var token : String? {
        get {
            return KeychainManager.keychain["token"]
        }
        set(newToken){
           KeychainManager.keychain["token"] = newToken
        }
    }
    //static var refreshToken : String? {} //Todo: eventually, upgrade the auth flow.
    static var username: String? {
        get {
            return KeychainManager.keychain["username"]
        }
        set(newUsername){
            KeychainManager.keychain["username"] = newUsername
        }
    }
    static var password : String? {
        get {
            return KeychainManager.keychain["password"]
        }
        set(newPassword){
            KeychainManager.keychain["password"] = newPassword
        }
    }
    
    
}
