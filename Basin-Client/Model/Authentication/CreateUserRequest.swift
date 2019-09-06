//
//  LoginRequest.swift
//  Conflux-Client
//
//  Created by Zaccari Silverman on 6/23/19.
//  Copyright © 2019 macosten. All rights reserved.
//

import Foundation

struct CreateUserRequest: Codable {
    let name: String
    let email: String
    let password: String
    let verifyPassword: String
}
