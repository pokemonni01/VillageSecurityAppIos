//
//  ListHistory.swift
//  VillageSecurityAppIos
//
//  Created by Wachirapong on 29/5/2561 BE.
//  Copyright © 2561 Wachirapong. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ListHistory {
    
    let pk : Int?
    let statusCheckIn : String?
    let statusCheckout : String?
    let point : Point?
    let timeCheckIn : String?
    let timeCheckout : String?
    
    init(from json: JSON) {
        pk = json["pk"].intValue
        statusCheckIn = json["status_checkin"].stringValue
        statusCheckout = json["status_checkout"].stringValue
        point = Point(from: json["point"])
        timeCheckIn = json["time_checkin"].stringValue
        timeCheckout = json["time_checkout"].stringValue
    }
}
