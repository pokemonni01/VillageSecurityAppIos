//
//  UserData.swift
//  VillageSecurityAppIos
//
//  Created by Wachiraphong Prasoetwong on 15/2/2561 BE.
//  Copyright © 2561 Wachirapong. All rights reserved.
//

import Foundation

public struct UserData : Codable {
    let username : String?
    let detail : Detail?
    let token : String?
    
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
}
