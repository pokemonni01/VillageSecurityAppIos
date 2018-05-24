//
//  SetPasswordResponse.swift
//  VillageSecurityAppIos
//
//  Created by Wachiraphong Prasoetwong on 24/5/2561 BE.
//  Copyright © 2561 Wachirapong. All rights reserved.
//

import Foundation
import SwiftyJSON

struct SetPasswordResponse {
    let status : String?
    let message : String?
    let title : String?
    
    init(from json: JSON) {
        status = json["status"].stringValue
        message = json["message"].stringValue
        title = json["title"].stringValue
    }
}
