//
//  ListHistoryGuardAPI.swift
//  VillageSecurityAppIos
//
//  Created by Wachiraphong Prasoetwong on 30/4/2561 BE.
//  Copyright © 2561 Wachirapong. All rights reserved.
//

import Foundation
import Alamofire

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
            case .success:
                do {
                    let response = try JSONDecoder().decode(ListHistoryGuardResponse.self, from: response.data!)
                    if (response.status! == ApiConstants.SUCCESS) {
                        delegate.onRequestListHistoryGuardSuccess(response: response)
                    } else {
                        delegate.onRequestListHistoryGuardSuccess(response: response)
                    }
                } catch {
                    print(error) // any decoding error will be printed here!
                }
            case .failure:
                delegate.onRequestListHistoryGuardError(title: "Error", message: "Message Error")
            }
        }
    }
    
}


protocol ListHistoryGuardDelegate {
    func onRequestListHistoryGuardSuccess(response: ListHistoryGuardResponse)
    func onRequestListHistoryGuardFail(response: ListHistoryGuardResponse)
    func onRequestListHistoryGuardError(title: String, message: String)
}