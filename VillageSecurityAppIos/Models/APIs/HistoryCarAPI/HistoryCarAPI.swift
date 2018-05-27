//
//  HistoryCarAPI.swift
//  VillageSecurityAppIos
//
//  Created by Wachirapong on 27/5/2561 BE.
//  Copyright © 2561 Wachirapong. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public class HistoryCarAPI {
    
    static func requestNotificationList(_ delegate: RequestHistoryCarListDelegate, villageId: Int, time: String) {
        let token = StringUtils.getTokenHeader(token: (ShareData.userData?.token)!)
        guard let listCarUrl = ShareData.generic?.listCarUrl else {
            delegate.onRequestHistoryCarListError()
            return
        }
        let url = "\(listCarUrl)\(villageId)/?time=\(time)"
        let headers: HTTPHeaders = [
            "Authorization": token,
            ]
        Alamofire.request(url, method: .get, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let response = HistoryCarResponse(from: JSON(value))
                if (response.status! == ApiConstants.SUCCESS) {
                    delegate.onRequestHistoryCarListSuccess(response: response)
                } else {
                    delegate.onRequestHistoryCarListFail(response: response)
                }
            case .failure(let error):
                print(error)
                delegate.onRequestHistoryCarListError()
            }
        }
    }
    
    static func sendQrCodeData(_ delegate: SendQrCodeDataDelegate, code: String, lat: String, lon: String) {
        let token = StringUtils.getTokenHeader(token: (ShareData.userData?.token)!)
        guard let qrUrl = ShareData.generic?.scanCodeUrl else {
            delegate.onSendQrCodeDataError()
            return
        }
        let parameters: Parameters = [
            "code": code,
            "user_type": "user",
            "lat": lat,
            "lon": lon
        ]
        let headers: HTTPHeaders = [
            "Authorization": token,
            ]
        Alamofire.request(qrUrl, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate().responseJSON { response in
            switch response.result {
                case .success(let value):
                    let response = QrCode(from: JSON(value))
                    if (response.status! == ApiConstants.SUCCESS) {
                        delegate.onSendQrCodeDataSuccess(response: response)
                    } else {
                        delegate.onSendQrCodeDataFail(response: response)
                    }
                case .failure(let error):
                    print(error)
                    delegate.onSendQrCodeDataError()
            }
        }
    }
}

protocol RequestHistoryCarListDelegate {
    func onRequestHistoryCarListSuccess(response: HistoryCarResponse)
    func onRequestHistoryCarListFail(response: HistoryCarResponse)
    func onRequestHistoryCarListError()
}

protocol SendQrCodeDataDelegate {
    func onSendQrCodeDataSuccess(response: QrCode)
    func onSendQrCodeDataFail(response: QrCode)
    func onSendQrCodeDataError()
}
