//
//  SetPasswordAPI.swift
//  VillageSecurityAppIos
//
//  Created by Wachiraphong Prasoetwong on 24/5/2561 BE.
//  Copyright © 2561 Wachirapong. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public class SetPasswordAPI {
    
    static func requestSetPassword(_ delegate: SetPasswordDelegate, _ oldPassword: String, _ password: String) {
        let parameters: Parameters = [
            "old_password": oldPassword,
            "password": password
        ]
        let token = StringUtils.getTokenHeader(token: (ShareData.userData?.token)!)
        let url = ShareData.generic?.changePasswordUrl ?? ""
        let headers: HTTPHeaders = [
            "Authorization": token,
            ]
        Alamofire.request(url, method: .post, parameters: parameters, headers: headers).validate().responseJSON { response in
            switch response.result {
                case .success(let value):
                    let response = SetPasswordResponse(from: JSON(value))
                    if (response.status! == ApiConstants.SUCCESS) {
                        delegate.onRequestSetPasswordSuccess(response: response)
                    } else {
                        delegate.onRequestSetPasswordFail(response: response)
                    }
                case .failure(let error):
                    print(error)
                    delegate.onRequestSetPasswordError(title: "Error", message: "Message Error")
            }
        }
    }
    
}

protocol SetPasswordDelegate {
    func onRequestSetPasswordSuccess(response: SetPasswordResponse)
    func onRequestSetPasswordFail(response: SetPasswordResponse)
    func onRequestSetPasswordError(title: String, message: String)
}
