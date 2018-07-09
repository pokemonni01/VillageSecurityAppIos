//
//  StringUtils.swift
//  VillageSecurityAppIos
//
//  Created by Wachiraphong Prasoetwong on 15/4/2561 BE.
//  Copyright © 2561 Wachirapong. All rights reserved.
//

import Foundation

class StringUtils {
    static func getTokenHeader(token: String) -> String {
        return "token "+token
    }
}
