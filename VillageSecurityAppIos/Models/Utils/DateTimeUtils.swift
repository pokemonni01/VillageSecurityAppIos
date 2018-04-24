//
//  DateUtils.swift
//  VillageSecurityAppIos
//
//  Created by Wachiraphong Prasoetwong on 21/4/2561 BE.
//  Copyright © 2561 Wachirapong. All rights reserved.
//

import Foundation

class DateTimeUtils {
    static func getCurrentDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter.string(from: date)
    }
    
    static func getDateString(date: Date) -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter.string(from: date)
    }
}
