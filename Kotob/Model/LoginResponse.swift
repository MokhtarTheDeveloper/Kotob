//
//  LoginResponse.swift
//  Kotob
//
//  Created by Mokhtar on 9/19/18.
//  Copyright © 2018 Mokhtar. All rights reserved.
//

import Foundation

struct LoginResponse : Codable {
    var success : Bool?
    var confirmed : Bool?
    var message : String?
    var UserId : Int?
}
