//
//  NotificationAPI.swift
//  VillageSecurityAppIos
//
//  Created by Wachirapong on 26/5/2561 BE.
//  Copyright © 2561 Wachirapong. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public class NotificationAPI {
    
    static func requestNotificationList(_ delegate: RequestNotificationListDelegate) {
        let token = StringUtils.getTokenHeader(token: (ShareData.userData?.token)!)
        guard let notificationUrl = ShareData.generic?.listNotificationUrl else {
            delegate.onRequestNotificationListError()
            return
        }
        guard let pk = ShareData.userData?.detail?.pk else {
            delegate.onRequestNotificationListError()
            return
        }
        let url = "\(notificationUrl)\(pk)/"
        let headers: HTTPHeaders = [
            "Authorization": token,
            ]
        Alamofire.request(url, method: .get, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let response = GetNotificationResponse(from: JSON(value))
                if (response.status! == ApiConstants.SUCCESS) {
                    delegate.onRequestNotificationListSuccess(response: response)
                } else {
                    delegate.onRequestNotificationListFail(response: response)
                }
            case .failure(let error):
                print(error)
                delegate.onRequestNotificationListError()
            }
        }
    }
    
    static func requestNotificationDetail(_ delegate: RequestNotificationDetailDelegate, noticId: Int?) {
        guard let notificationUrl = ShareData.generic?.notificationUrl else {
            delegate.onRequestNotificationDetailError()
            return
        }
        guard let noticId = noticId else {
            delegate.onRequestNotificationDetailError()
            return
        }
        let url = "\(notificationUrl)\(noticId)/"
                let token = StringUtils.getTokenHeader(token: ShareData.userData?.token ?? "")
        let headers: HTTPHeaders = [
            "Authorization": token,
            ]
        Alamofire.request(url, method: .get, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let response = Notic(from: JSON(value))
                if (response.status! == ApiConstants.SUCCESS) {
                    delegate.onRequestNotificationDetailSuccess(response: response)
                } else {
                    delegate.onRequestNotificationDetailFail(response: response)
                }
            case .failure(let error):
                print(error)
                delegate.onRequestNotificationDetailError()
            }
        }
    }
    
}

protocol RequestNotificationListDelegate {
    func onRequestNotificationListSuccess(response: GetNotificationResponse)
    func onRequestNotificationListFail(response: GetNotificationResponse)
    func onRequestNotificationListError()
}

protocol RequestNotificationDetailDelegate {
    func onRequestNotificationDetailSuccess(response: Notic)
    func onRequestNotificationDetailFail(response: Notic)
    func onRequestNotificationDetailError()
}
