//
//  SettingResponse.swift
//  VillageSecurityAppIos
//
//  Created by Wachiraphong Prasoetwong on 24/5/2561 BE.
//  Copyright © 2561 Wachirapong. All rights reserved.
//

import Foundation
import SwiftyJSON

struct SettingResponse {
//    {"timeSendLocation":0,"rankCheckCar":0,"rankCheckLocation":0,"versionApp":"1.3.0"}
    let timeSendLocation : Int?
    let rankCheckCar : Int?
    let rankCheckLocation : Int?
    let versionApp : String?
    
    init(from json: JSON) {
        timeSendLocation = json["timeSendLocation"].intValue
        rankCheckCar = json["rankCheckCar"].intValue
        rankCheckLocation = json["rankCheckLocation"].intValue
        versionApp = json["versionApp"].stringValue
    }
}
