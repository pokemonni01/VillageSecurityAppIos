//
//  UserData.swift
//  VillageSecurityAppIos
//
//  Created by Wachiraphong Prasoetwong on 15/2/2561 BE.
//  Copyright © 2561 Wachirapong. All rights reserved.
//

import Foundation

public struct UserData : Codable {
    var username : String?
    var detail : Detail?
    var token : String?
    
    enum CodingKeys: String, CodingKey {
        case username = "username"
        case detail = "detail"
        case token = "token"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        username = try values.decodeIfPresent(String.self, forKey: .username)
        detail = try values.decodeIfPresent(Detail.self, forKey: .detail)
        token = try values.decodeIfPresent(String.self, forKey: .token)
    }
    
    init(username: String, detail: Detail, token: String) {
        self.username = username
        self.detail = detail
        self.token = token
    }
}
