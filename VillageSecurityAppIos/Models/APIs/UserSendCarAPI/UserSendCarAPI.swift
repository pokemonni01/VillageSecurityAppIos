//
//  UserSendCarAPI.swift
//  Secure A
//
//  Created by Wachirapong on 24/10/2561 BE.
//  Copyright © 2561 Wachirapong. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public class UserSendCarAPI {
    
    static func sendCarData(_ delegate: SendCarDataDelegate, homeId: Int, carId: String, carColor: String, carBrand: String, lat: String, lon: String) {
        let token = StringUtils.getTokenHeader(token: (ShareData.userData?.token)!)
        guard let sendCarDataUrl = ShareData.generic?.userSendCodeUrl else {
            delegate.onSendCarDataError()
            return
        }
        let parameters: Parameters = [
            "user_id": ShareData.userData?.detail?.pk ?? 0,
            "number_car": carId,
            "brand_car": carBrand,
            "home": homeId,
            "color_car": carColor,
            "lat": lat,
            "lon": lon
        ]
        let headers: HTTPHeaders = [
            "Authorization": token,
            ]
        Alamofire.request(sendCarDataUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let response = SendCarDataResponse(from: JSON(value))
                if (response.status! == ApiConstants.SUCCESS) {
                    delegate.onSendCarDataSuccess(response: response)
                } else {
                    delegate.onSendCarDataFail(response: response)
                }
            case .failure(let error):
                print(error)
                delegate.onSendCarDataError()
            }
        }
    }
}

protocol SendCarDataDelegate {
    func onSendCarDataSuccess(response: SendCarDataResponse)
    func onSendCarDataFail(response: SendCarDataResponse)
    func onSendCarDataError()
}
