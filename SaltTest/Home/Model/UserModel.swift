//
//  UserModel.swift
//  SaltTest
//
//  Created by Phincon on 20/09/22.
//

import Foundation
import UIKit

struct UserModel : Codable {
    let page : Int?
    let per_page : Int?
    let total : Int?
    let total_pages : Int?
    let data : [DataUserModel]?
    let support : SupportUserModel?

    enum CodingKeys: String, CodingKey {

        case page = "page"
        case per_page = "per_page"
        case total = "total"
        case total_pages = "total_pages"
        case data = "data"
        case support = "support"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        page = try values.decodeIfPresent(Int.self, forKey: .page)
        per_page = try values.decodeIfPresent(Int.self, forKey: .per_page)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
        total_pages = try values.decodeIfPresent(Int.self, forKey: .total_pages)
        data = try values.decodeIfPresent([DataUserModel].self, forKey: .data)
        support = try values.decodeIfPresent(SupportUserModel.self, forKey: .support)
    }
}

struct SupportUserModel : Codable {
    let url : String?
    let text : String?

    enum CodingKeys: String, CodingKey {

        case url = "url"
        case text = "text"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        text = try values.decodeIfPresent(String.self, forKey: .text)
    }

}

struct DataUserModel : Codable {
    let id : Int?
    let email : String?
    let first_name : String?
    let last_name : String?
    let avatar : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case email = "email"
        case first_name = "first_name"
        case last_name = "last_name"
        case avatar = "avatar"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        avatar = try values.decodeIfPresent(String.self, forKey: .avatar)
    }

}

