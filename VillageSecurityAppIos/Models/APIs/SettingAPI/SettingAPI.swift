//
//  SettingAPI.swift
//  VillageSecurityAppIos
//
//  Created by Wachiraphong Prasoetwong on 24/5/2561 BE.
//  Copyright © 2561 Wachirapong. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public class SettingAPI {
    
    static func requestSetting(_ delegate: SettingDelegate) {
        let token = StringUtils.getTokenHeader(token: (ShareData.userData?.token)!)
        let url = ShareData.generic?.settingAppUrl ?? ""
        let headers: HTTPHeaders = [
            "Authorization": token,
            ]
        Alamofire.request(url, method: .get, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let response = SettingResponse(from: JSON(value))
                delegate.onRequestSettingSuccess(response: response)
            case .failure(let error):
                print(error)
                delegate.onRequestSettingError()
            }
        }
    }
    
}

protocol SettingDelegate {
    func onRequestSettingSuccess(response: SettingResponse)
    func onRequestSettingError()
}
