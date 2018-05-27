//
//  QrCode.swift
//  VillageSecurityAppIos
//
//  Created by Wachirapong on 27/5/2561 BE.
//  Copyright © 2561 Wachirapong. All rights reserved.
//

/*
 {
     "pk": 45,
     "code": "1234567890",
     "number_car": "1111",
     "detail": "",
     "time_in": "13-05-2018 11:21:33",
     "home": {
     "pk": 24,
     "number": "333",
     "address": "333",
     "zone": 5,
     "lat": "15.1438724",
     "lon": "102.2134838"
     },
     "guard": [
        3
     ],
     "time_guard": null,
     "time_user": null,
     "guard_check": null,
     "status_guard": "NO",
     "status_user": "NO",
     "status_home": "NO",
     "code_status": "0",
     "active_sleep": "YES",
     "village": 2,
     "time_out": null,
     "time": "13-05-2018 11:21:33"
 }
 */

import Foundation
import SwiftyJSON

struct QrCode {
    let pk: Int?
    let code, numberCar, detail, timeIn: String
    let home: Home?
    let guardIds: [Int]?
    let timeGuard, timeUser, guardCheck, statusGuard: String
    let statusUser, statusHome, codeStatus, activeSleep: String
    let village: Int?
    let timeOut, time: String
    let status : String?
    let message : String?
    let title : String?
    
    init(from json: JSON) {
        pk = json["pk"].intValue
        code = json["code"].stringValue
        numberCar = json["number_car"].stringValue
        detail = json["detail"].stringValue
        timeIn = json["time_in"].stringValue
        home = Home(from: json["home"])
        guardIds = json["guard"].arrayObject as? [Int]
        timeGuard = json["time_guard"].stringValue
        timeUser = json["time_user"].stringValue
        guardCheck = json["guard_check"].stringValue
        statusGuard = json["status_guard"].stringValue
        statusUser = json["status_user"].stringValue
        statusHome = json["status_home"].stringValue
        codeStatus = json["code_status"].stringValue
        activeSleep = json["active_sleep"].stringValue
        village = json["village"].intValue
        timeOut = json["time_out"].stringValue
        time = json["time"].stringValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        title = json["title"].stringValue
    }
}
