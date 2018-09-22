//
//  registerationResponse.swift
//  Kotob
//
//  Created by Mokhtar on 9/20/18.
//  Copyright © 2018 Mokhtar. All rights reserved.
//

import Foundation

struct RegisterationResponse : Codable {
    let success : Bool?
    let fail : Bool?
    let UserId : Int?
    let message : String?
}
