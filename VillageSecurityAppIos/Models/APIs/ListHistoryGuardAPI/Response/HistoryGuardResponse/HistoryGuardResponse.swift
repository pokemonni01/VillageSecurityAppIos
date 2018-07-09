//
//  HistoryGuardResponse.swift
//  VillageSecurityAppIos
//
//  Created by Wachirapong on 29/5/2561 BE.
//  Copyright © 2561 Wachirapong. All rights reserved.
//

import Foundation
import SwiftyJSON

struct HistoryGuardResponse {
    
    let status : String?
    let mZone : Zone?
    let message : String?
    let title : String?
    let listHistory : [ListHistory]?
    
    init(from json: JSON) {
        status = json["status"].stringValue
        message = json["message"].stringValue
        title = json["title"].stringValue
        mZone = Zone(from: json["zone"])
        listHistory = [ListHistory]()
        for history in json["list_history"].arrayValue {
            listHistory?.append(ListHistory(from: history))
        }
    }
}
