//
//  Generic.swift
//  VillageSecurityAppIos
//
//  Created by Wachirapong on 30/12/2560 BE.
//  Copyright © 2560 Wachirapong. All rights reserved.
//

import Foundation

public struct Generic : Codable {
    let listHomeUrl : String?
    let statusUserUrl : String?
    let checkPointUrl : String?
    let listCheckCarUrl : String?
    let listGuardBehaviorUrl : String?
    let listGuardUrl : String?
    let listNotificationUrl : String?
    let changePassword : String?
    let singUpGuardUrl : String?
    let deletePointUrl : String?
    let listZoneUrl : String?
    let typeUserUrl : String?
    let deviceUrl : String?
    let rankCheckCar : String?
    let listCarUrl : String?
    let listHistoryGuardUrl : String?
    let rankCheckCarUrl : String?
    let typeGuardUrl : String?
    let jopGuardUrl : String?
    let singUpUserUrl : String?
    let checkGuardUrl : String?
    let scanCodeUrl : String?
    let reportCarUrl : String?
    let listCar : String?
    let listGuardLocationHourUrl : String?
    let listGuardLocationUrl : String?
    let settingAppUrl : String?
    let settingAppUserUrl : String?
    let listPointUrl : String?
    let deleteGuardUrl : String?
    let rankCheckLocation : String?
    let notification : String?
    let historyGuardUrl : String?
    let singInUserUrl : String?
    let notificationUrl : String?
    let locationGuardUrl : String?
    let userSendCodeUrl : String?
    let changePasswordUrl : String?
    let listVillageUrl : String?
    let locationGuardHourUrl : String?
    let singInGuardUrl : String?
    let rankCheckLocationUrl : String?
    let locationGuard : String?
    let listNotification : String?
    let mainUrl : String?
    let statusUser : String?
    
    enum CodingKeys: String, CodingKey {
        
        case listHomeUrl = "listHomeUrl"
        case statusUserUrl = "statusUserUrl"
        case checkPointUrl = "checkPointUrl"
        case listCheckCarUrl = "listCheckCarUrl"
        case listGuardBehaviorUrl = "listGuardBehaviorUrl"
        case listGuardUrl = "listGuardUrl"
        case listNotificationUrl = "listNotificationUrl"
        case changePassword = "changePassword"
        case singUpGuardUrl = "singUpGuardUrl"
        case deletePointUrl = "deletePointUrl"
        case listZoneUrl = "listZoneUrl"
        case typeUserUrl = "typeUserUrl"
        case deviceUrl = "deviceUrl"
        case rankCheckCar = "rankCheckCar"
        case listCarUrl = "listCarUrl"
        case listHistoryGuardUrl = "listHistoryGuardUrl"
        case rankCheckCarUrl = "rankCheckCarUrl"
        case typeGuardUrl = "typeGuardUrl"
        case jopGuardUrl = "jopGuardUrl"
        case singUpUserUrl = "singUpUserUrl"
        case checkGuardUrl = "checkGuardUrl"
        case scanCodeUrl = "scanCodeUrl"
        case reportCarUrl = "reportCarUrl"
        case listCar = "listCar"
        case listGuardLocationHourUrl = "listGuardLocationHourUrl"
        case listGuardLocationUrl = "listGuardLocationUrl"
        case settingAppUrl = "settingAppUrl"
        case settingAppUserUrl = "settingAppUserUrl"
        case listPointUrl = "listPointUrl"
        case deleteGuardUrl = "deleteGuardUrl"
        case rankCheckLocation = "rankCheckLocation"
        case notification = "notification"
        case historyGuardUrl = "historyGuardUrl"
        case singInUserUrl = "singInUserUrl"
        case notificationUrl = "notificationUrl"
        case locationGuardUrl = "locationGuardUrl"
        case userSendCodeUrl = "userSendCodeUrl"
        case changePasswordUrl = "changePasswordUrl"
        case listVillageUrl = "listVillageUrl"
        case locationGuardHourUrl = "locationGuardHourUrl"
        case singInGuardUrl = "singInGuardUrl"
        case rankCheckLocationUrl = "rankCheckLocationUrl"
        case locationGuard = "locationGuard"
        case listNotification = "listNotification"
        case mainUrl = "mainUrl"
        case statusUser = "statusUser"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        listHomeUrl = try values.decodeIfPresent(String.self, forKey: .listHomeUrl)
        statusUserUrl = try values.decodeIfPresent(String.self, forKey: .statusUserUrl)
        checkPointUrl = try values.decodeIfPresent(String.self, forKey: .checkPointUrl)
        listCheckCarUrl = try values.decodeIfPresent(String.self, forKey: .listCheckCarUrl)
        listGuardBehaviorUrl = try values.decodeIfPresent(String.self, forKey: .listGuardBehaviorUrl)
        listGuardUrl = try values.decodeIfPresent(String.self, forKey: .listGuardUrl)
        listNotificationUrl = try values.decodeIfPresent(String.self, forKey: .listNotificationUrl)
        changePassword = try values.decodeIfPresent(String.self, forKey: .changePassword)
        singUpGuardUrl = try values.decodeIfPresent(String.self, forKey: .singUpGuardUrl)
        deletePointUrl = try values.decodeIfPresent(String.self, forKey: .deletePointUrl)
        listZoneUrl = try values.decodeIfPresent(String.self, forKey: .listZoneUrl)
        typeUserUrl = try values.decodeIfPresent(String.self, forKey: .typeUserUrl)
        deviceUrl = try values.decodeIfPresent(String.self, forKey: .deviceUrl)
        rankCheckCar = try values.decodeIfPresent(String.self, forKey: .rankCheckCar)
        listCarUrl = try values.decodeIfPresent(String.self, forKey: .listCarUrl)
        listHistoryGuardUrl = try values.decodeIfPresent(String.self, forKey: .listHistoryGuardUrl)
        rankCheckCarUrl = try values.decodeIfPresent(String.self, forKey: .rankCheckCarUrl)
        typeGuardUrl = try values.decodeIfPresent(String.self, forKey: .typeGuardUrl)
        jopGuardUrl = try values.decodeIfPresent(String.self, forKey: .jopGuardUrl)
        singUpUserUrl = try values.decodeIfPresent(String.self, forKey: .singUpUserUrl)
        checkGuardUrl = try values.decodeIfPresent(String.self, forKey: .checkGuardUrl)
        scanCodeUrl = try values.decodeIfPresent(String.self, forKey: .scanCodeUrl)
        reportCarUrl = try values.decodeIfPresent(String.self, forKey: .reportCarUrl)
        listCar = try values.decodeIfPresent(String.self, forKey: .listCar)
        listGuardLocationHourUrl = try values.decodeIfPresent(String.self, forKey: .listGuardLocationHourUrl)
        listGuardLocationUrl = try values.decodeIfPresent(String.self, forKey: .listGuardLocationUrl)
        settingAppUrl = try values.decodeIfPresent(String.self, forKey: .settingAppUrl)
        settingAppUserUrl = try values.decodeIfPresent(String.self, forKey: .settingAppUserUrl)
        listPointUrl = try values.decodeIfPresent(String.self, forKey: .listPointUrl)
        deleteGuardUrl = try values.decodeIfPresent(String.self, forKey: .deleteGuardUrl)
        rankCheckLocation = try values.decodeIfPresent(String.self, forKey: .rankCheckLocation)
        notification = try values.decodeIfPresent(String.self, forKey: .notification)
        historyGuardUrl = try values.decodeIfPresent(String.self, forKey: .historyGuardUrl)
        singInUserUrl = try values.decodeIfPresent(String.self, forKey: .singInUserUrl)
        notificationUrl = try values.decodeIfPresent(String.self, forKey: .notificationUrl)
        locationGuardUrl = try values.decodeIfPresent(String.self, forKey: .locationGuardUrl)
        userSendCodeUrl = try values.decodeIfPresent(String.self, forKey: .userSendCodeUrl)
        changePasswordUrl = try values.decodeIfPresent(String.self, forKey: .changePasswordUrl)
        listVillageUrl = try values.decodeIfPresent(String.self, forKey: .listVillageUrl)
        locationGuardHourUrl = try values.decodeIfPresent(String.self, forKey: .locationGuardHourUrl)
        singInGuardUrl = try values.decodeIfPresent(String.self, forKey: .singInGuardUrl)
        rankCheckLocationUrl = try values.decodeIfPresent(String.self, forKey: .rankCheckLocationUrl)
        locationGuard = try values.decodeIfPresent(String.self, forKey: .locationGuard)
        listNotification = try values.decodeIfPresent(String.self, forKey: .listNotification)
        mainUrl = try values.decodeIfPresent(String.self, forKey: .mainUrl)
        statusUser = try values.decodeIfPresent(String.self, forKey: .statusUser)
    }
}
