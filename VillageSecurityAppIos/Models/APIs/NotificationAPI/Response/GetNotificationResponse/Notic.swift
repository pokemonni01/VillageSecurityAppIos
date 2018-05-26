//
//  Notic.swift
//  VillageSecurityAppIos
//
//  Created by Wachirapong on 26/5/2561 BE.
//  Copyright © 2561 Wachirapong. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Notic {
    /*
     {
         "pk": 56,
         "title": "แจ้งเตือนรถเข้าเยี่ยมบ้าน",
         "detail": "มีรถเข้าไปบ้านเลขที่ 333 รถทะเบียน 1111",
         "time": "13-05-2018 11:21:33",
         "user_general": {},
         "home": [
             {
                 "pk": 24,
                 "number": "333",
                 "address": "333",
                 "zone": 5,
                 "lat": "15.1438724",
                 "lon": "102.2134838"
             }
            ]
         },
         "status_read": "YES"
     }
    */
    let pk: Int?
    let status : String?
    let message : String?
    let title : String?
    let detail : String?
    let time : String?
    let userGeneral : Detail?
    let statusRead : String?
    
    init(from json: JSON) {
        pk = json["pk"].intValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        title = json["title"].stringValue
        detail = json["detail"].stringValue
        time = json["time"].stringValue
        userGeneral = Detail(from: json["user_general"])
        statusRead = json["status_read"].stringValue
    }
}
