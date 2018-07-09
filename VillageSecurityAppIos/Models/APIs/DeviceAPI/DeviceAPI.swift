//
//  DeviceAPI.swift
//  VillageSecurityAppIos
//
//  Created by Wachirapong on 8/7/2561 BE.
//  Copyright © 2561 Wachirapong. All rights reserved.
//

import Foundation
import Alamofire
import Firebase
import SwiftyJSON

public class DeviceApi {
    
    static func sendDevice(_ delegate: SendDeviceDelegate, _ username: String, _ active: Bool) {
        let token = StringUtils.getTokenHeader(token: (ShareData.userData?.token)!)
        guard let sendDeviceUrl = ShareData.generic?.deviceUrl else {
            delegate.onSendDeviceError()
            return
        }
        let firebaseToken = InstanceID.instanceID().token() ?? ""
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        let parameters: Parameters = [
            "active": active,
            "device_id": deviceID,
            "name": username,
            "registration_id": firebaseToken,
            "type": "ios"
        ]
        let headers: HTTPHeaders = [
            "Authorization": token,
            ]
        Alamofire.request(sendDeviceUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate().responseJSON { response in
            print(response)
            switch response.result {
            case .success(let value):
                let response = SendDeviceResponse(from: JSON(value))
                if (response.status! == ApiConstants.SUCCESS) {
                    delegate.onSendDeviceSuccess(response: response)
                } else {
                    delegate.onSendDeviceFail(response: response)
                }
            case .failure: break
//                delegate.onRequestLoginError(title: "Error", message: "Message Error")
            }
        }
    }
}
