//
//  GetNotificationResponse.swift
//  VillageSecurityAppIos
//
//  Created by Wachirapong on 26/5/2561 BE.
//  Copyright © 2561 Wachirapong. All rights reserved.
//

import Foundation
import SwiftyJSON
/*
 {
    "count_not_read": 4,
    "status": "success",
    "message": "ข้อมูลมีอยู่ในระบบ,
    "title": "ดึงข้อมูลสำเร็จ",
    "notic": []
 }
 */
struct GetNotificationResponse {
    let status : String?
    let message : String?
    let title : String?
    let countNotRead : Int?
    let notics : [Notic]?
    
    init(from json: JSON) {
        status = json["status"].stringValue
        message = json["message"].stringValue
        title = json["title"].stringValue
        countNotRead = json["count_not_read"].intValue
        notics = [Notic]()
        for notic in json["notic"].arrayValue {
            notics?.append(Notic(from: notic))
        }
    }
}
