//
//  LoginDelegate.swift
//  VillageSecurityAppIos
//
//  Created by Wachirapong on 10/1/2561 BE.
//  Copyright © 2561 Wachirapong. All rights reserved.
//

import Foundation

public protocol LoginDelegate {
    func onRequestLoginSuccess(response: LoginResponse)
    func onRequestLoginFail(response: LoginResponse)
    func onRequestLoginError(title: String, message: String)
}
