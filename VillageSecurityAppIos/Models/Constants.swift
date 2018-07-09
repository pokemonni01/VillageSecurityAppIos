//
//  Constants.swift
//  VillageSecurityAppIos
//
//  Created by Wachirapong on 1/1/2561 BE.
//  Copyright © 2561 Wachirapong. All rights reserved.
//

import Foundation

enum Config {
    static let baseURL = "http://54.254.254.52/urls/"
}

enum ApiConstants {
    static let SUCCESS = "success"
    static let FAIL = "fail"
}

enum IdentifierNames {
    static let loginViewController = "LoginViewController"
    static let splashScreenViewController = "SplashScreenViewController"
    static let userMenuViewController = "UserMenuViewController"
    static let userMenuNavigationViewController = "UserMenuNavigationViewController"
    static let scanQRController = "ScanQRController"
    static let notificationViewController = "NotificationViewController"
    static let cellReuseIdentifier = "cellReuseIdentifier"
    static let notificationDetailViewController = "NotificationDetailViewController"
    static let workHistoryViewController = "WorkHistoryViewController"
}
