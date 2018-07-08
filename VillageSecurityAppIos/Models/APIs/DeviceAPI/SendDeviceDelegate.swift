//
//  SendDeviceDelegate.swift
//  VillageSecurityAppIos
//
//  Created by Wachirapong on 8/7/2561 BE.
//  Copyright © 2561 Wachirapong. All rights reserved.
//

import Foundation

protocol SendDeviceDelegate {
    func onSendDeviceSuccess(response: SendDeviceResponse)
    func onSendDeviceFail(response: SendDeviceResponse)
    func onSendDeviceError()
}
