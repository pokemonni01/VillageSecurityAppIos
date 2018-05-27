//
//  HistoryCarResponse.swift
//  VillageSecurityAppIos
//
//  Created by Wachirapong on 27/5/2561 BE.
//  Copyright © 2561 Wachirapong. All rights reserved.
//

import Foundation
import SwiftyJSON

struct HistoryCarResponse {
    let status : String?
    let message : String?
    let title : String?
    let qrcodes : [QrCode]?
    
    init(from json: JSON) {
        status = json["status"].stringValue
        message = json["message"].stringValue
        title = json["title"].stringValue
        qrcodes = [QrCode]()
        for qrcode in json["qrcode"].arrayValue {
            qrcodes?.append(QrCode(from: qrcode))
        }
    }
}
