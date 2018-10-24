//
//  SendCarDataResponse.swift
//  Secure A
//
//  Created by Wachirapong on 24/10/2561 BE.
//  Copyright © 2561 Wachirapong. All rights reserved.
//

import Foundation
import SwiftyJSON

struct SendCarDataResponse {
    let status : String?
    let message : String?
    let title : String?
    
    init(from json: JSON) {
        status = json["status"].stringValue
        message = json["message"].stringValue
        title = json["title"].stringValue
    }
}
