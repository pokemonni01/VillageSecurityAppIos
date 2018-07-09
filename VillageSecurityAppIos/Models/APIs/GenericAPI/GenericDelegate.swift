//
//  GenericDelegate.swift
//  VillageSecurityAppIos
//
//  Created by Wachirapong on 7/1/2561 BE.
//  Copyright © 2561 Wachirapong. All rights reserved.
//

import Foundation

public protocol GenericDelegate {
    func onGetGenericSuccess(generic: Generic)
    func onGetGenericFail(generic: Generic)
    func onGetGenericError(title: String, message: String)
}
