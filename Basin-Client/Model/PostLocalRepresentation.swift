//
//  IncomingPostRepresentation.swift
//  Basin-Client
//
//  Created by Zaccari Silverman on 9/13/19.
//  Copyright © 2019 macosten. All rights reserved.
//

import Foundation

struct PostLocalRepresentation : Codable {
    //The database ID of the post.
    let id : Int
    
    //Title of the post.
    let title : String
    
    
    let textContent : String
    
    //Be sure to keep the fields here and the PublicUserInformation type in the server identical...
    
}
