//
//  VaporError.swift
//  Conflux-Client
//
//  Created by Zaccari Silverman on 7/10/19.
//  Copyright © 2019 macosten. All rights reserved.
//

import Foundation

///This is a type meant to map to the kinds of errors that Vapor returns.
struct VaporError : Codable {
    let error : Bool
    let reason : String
}
