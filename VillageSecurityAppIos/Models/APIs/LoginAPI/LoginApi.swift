//
//  LoginApi.swift
//  VillageSecurityAppIos
//
//  Created by Wachirapong on 10/1/2561 BE.
//  Copyright © 2561 Wachirapong. All rights reserved.
//

import Foundation
import Alamofire

public class LoginApi {
    
    public static func requestLogin(_ delegate: LoginDelegate, _ username: String, _ password: String) {
        let parameters: Parameters = [
            "username": username,
            "password": password
        ]
        Alamofire.request((ShareData.generic?.singInUserUrl)!, method: .post, parameters: parameters).validate().responseJSON { response in
            switch response.result {
            case .success:
                do {
                    let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: response.data!)
                    if (loginResponse.status! == ApiConstants.SUCCESS) {
                        delegate.onRequestLoginSuccess(response: loginResponse)
                    } else {
                        delegate.onRequestLoginFail(response: loginResponse)
                    }
                } catch {
                    print(error) // any decoding error will be printed here!
                }
                
            case .failure:
                delegate.onRequestLoginError(title: "Error", message: "Message Error")
            }
        }
    }
}
