//
//  WrappedUserAccessToken.swift
//  Conflux-Client
//
//  Created by Zaccari Silverman on 6/25/19.
//  Copyright © 2019 macosten. All rights reserved.
//

import Foundation

struct WrappedUserAccessToken: Codable {
    //Eventually we'll upgrade to using refresh tokens, but for now, we'll just use basic access tokens.
    let access_token: String
}
