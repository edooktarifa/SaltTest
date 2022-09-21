//
//  LoginModel.swift
//  SaltTest
//
//  Created by Phincon on 20/09/22.
//

import Foundation

struct LoginModel: Codable {
    var token: String?
    
    enum CodingKeys: String, CodingKey {
        case token
    }
}
