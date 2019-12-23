//
//  IncomingPostRepresentation.swift
//  Basin-Client
//
//  Created by Zaccari Silverman on 9/13/19.
//  Copyright © 2019 macosten. All rights reserved.
//

import Foundation

struct PostLocalRepresentation : Codable {
    
    let id : Int ///The database ID of the post.
    
    let title : String ///The title of the post.
    
    let userID : Int /// The ID of the user who created this post.
    
    let username: String ///The username of the user who created this post.
    
    let textContent : String ///The text content of this post.
    
    let createdAt : Date? ///The date this post was created.
    let updatedAt : Date? ///The date this post was edited last.
    //Be sure to keep the fields here and the PublicUserInformation type in the server identical...
    
    //For the future, it may be a good idea to have different types for "Stub" (just the id and title) and "Post" (which would have all the fields). This would save bandwidth.
    
}
