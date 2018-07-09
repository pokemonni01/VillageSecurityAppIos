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

public class ListHistoryGuardAPI {
    
    static func requestListHistoryGuard(_ delegate: ListHistoryGuardDelegate, villageId: Int?, zoneId: Int?, date: String) {
        guard let villageId = villageId else {
            delegate.onRequestListHistoryGuardError(title: "Error", message: "Message Error")
            return
        }
        guard let zoneId = zoneId else {
            delegate.onRequestListHistoryGuardError(title: "Error", message: "Message Error")
            return
        }
        let token = StringUtils.getTokenHeader(token: (ShareData.userData?.token)!)
        let listHistoryGuardUrl = (ShareData.generic?.listHistoryGuardUrl)! + "\(villageId)/\(zoneId)/?time=\(date)"
        let headers: HTTPHeaders = [
            "Authorization": token,
            ]
        Alamofire.request(listHistoryGuardUrl, method: .get,  headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let response = ListHistoryGuardResponse(from: JSON(value))
                if (response.status! == ApiConstants.SUCCESS) {
                    delegate.onRequestListHistoryGuardSuccess(response: response)
                } else {
                    delegate.onRequestListHistoryGuardSuccess(response: response)
                }
            case .failure(let error):
                print(error)
                delegate.onRequestListHistoryGuardError(title: "Error", message: "Message Error")
            }
        }
    }
    
    static func requestHistoryGuard(_ delegate: HistoryGuardDelegate, historyId: Int) {
        let token = StringUtils.getTokenHeader(token: (ShareData.userData?.token)!)
        if (ShareData.generic?.historyGuardUrl ?? "").isEmpty {
            delegate.onRequestHistoryGuardError()
        }
        let historyGuardUrl = (ShareData.generic?.historyGuardUrl)! + "\(historyId)/"
        let headers: HTTPHeaders = [
            "Authorization": token,
            ]
        Alamofire.request(historyGuardUrl, method: .get,  headers: headers).validate().responseJSON { response in
            switch response.result {
                case .success(let value):
                    let response = HistoryGuardResponse(from: JSON(value))
                    if (response.status! == ApiConstants.SUCCESS) {
                        delegate.onRequestHistoryGuardSuccess(response: response)
                    } else {
                        delegate.onRequestHistoryGuardFail(response: response)
                    }
                case .failure(let error):
                    print(error)
                    delegate.onRequestHistoryGuardError()
            }
        }
    }
    
}


protocol ListHistoryGuardDelegate {
    func onRequestListHistoryGuardSuccess(response: ListHistoryGuardResponse)
    func onRequestListHistoryGuardFail(response: ListHistoryGuardResponse)
    func onRequestListHistoryGuardError(title: String, message: String)
}

protocol HistoryGuardDelegate {
    func onRequestHistoryGuardSuccess(response: HistoryGuardResponse)
    func onRequestHistoryGuardFail(response: HistoryGuardResponse)
    func onRequestHistoryGuardError()
}
