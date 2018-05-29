//
//  Point.swift
//  VillageSecurityAppIos
//
//  Created by Wachirapong on 29/5/2561 BE.
//  Copyright © 2561 Wachirapong. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Point {
    
    let pk : Int?
    let zone : Int?
    let name : String?
    let lat : String?
    let lon : String?
    let status : String?
    
    init(from json: JSON) {
        pk = json["pk"].intValue
        zone = json["zone"].intValue
        name = json["name"].stringValue
        lat = json["lat"].stringValue
        lon = json["lon"].stringValue
        status = json["status"].stringValue
    }
}
