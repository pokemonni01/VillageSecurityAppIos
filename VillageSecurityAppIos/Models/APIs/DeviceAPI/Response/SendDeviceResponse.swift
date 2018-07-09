//
//  SendDeviceResponse.swift
//  VillageSecurityAppIos
//
//  Created by Wachirapong on 8/7/2561 BE.
//  Copyright © 2561 Wachirapong. All rights reserved.
//

import Foundation
import SwiftyJSON

struct SendDeviceResponse {
    let status : String?
    let message : String?
    let title : String?
    let type : String?
    let dateCreated : String?
    let active : Bool?
    let deviceId : String?
    let registrationId : String?
    let name : String?
    
    init(from json: JSON) {
        status = json["status"].stringValue
        message = json["message"].stringValue
        title = json["title"].stringValue
        type = json["type"].stringValue
        dateCreated = json["dateCreated"].stringValue
        active = json["active"].boolValue
        deviceId = json["deviceId"].stringValue
        registrationId = json["registrationId"].stringValue
        name = json["name"].stringValue
    }
}
