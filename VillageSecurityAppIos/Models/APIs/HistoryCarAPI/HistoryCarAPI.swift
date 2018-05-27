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
}

protocol RequestHistoryCarListDelegate {
    func onRequestHistoryCarListSuccess(response: HistoryCarResponse)
    func onRequestHistoryCarListFail(response: HistoryCarResponse)
    func onRequestHistoryCarListError()
}
