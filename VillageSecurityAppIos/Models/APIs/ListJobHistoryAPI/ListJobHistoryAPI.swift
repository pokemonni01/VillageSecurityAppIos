//
//  ListHistoryGuardAPI.swift
//  VillageSecurityAppIos
//
//  Created by Wachiraphong Prasoetwong on 30/4/2561 BE.
//  Copyright © 2561 Wachirapong. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public class ListJobHistoryAPI {
    
    static func requestListJobHistory(_ delegate: ListJobHistoryDelegate, pkGuard: Int, type: String, date: String) {
//        guard let villageId = villageId else {
//            delegate.onRequestListHistoryGuardError(title: "Error", message: "Message Error")
//            return
//        }
        let parameters: Parameters = [
            "id_guard": pkGuard,
            "q_type": type,
            "date": date,
        ]
        let token = StringUtils.getTokenHeader(token: (ShareData.userData?.token)!)
        let url = (ShareData.generic?.historyGuardUrl)!
        let headers: HTTPHeaders = [
            "Authorization": token,
            ]
        Alamofire.request(url, method: .post, parameters: parameters, headers: headers).validate().responseJSON { response in
            switch response.result {
                case .success(let value):
                    let response = ListJobHistoryResponse(from: JSON(value))
                    if (response.status! == ApiConstants.SUCCESS) {
                        delegate.onRequestListJobHistorySuccess(response: response)
                    } else {
                        delegate.onRequestListJobHistoryFail(response: response)
                    }
                case .failure(let error):
                    print(error)
                    delegate.onRequestListJobHistoryError(title: "Error", message: "Message Error")
            }
        }
    }
}

protocol ListJobHistoryDelegate {
    func onRequestListJobHistorySuccess(response: ListJobHistoryResponse)
    func onRequestListJobHistoryFail(response: ListJobHistoryResponse)
    func onRequestListJobHistoryError(title: String, message: String)
}
