//
//  ListZoneAPI.swift
//  VillageSecurityAppIos
//
//  Created by Wachiraphong Prasoetwong on 16/4/2561 BE.
//  Copyright © 2561 Wachirapong. All rights reserved.
//

import Foundation
import Alamofire


public class ListZoneApi {
    
    public static func requestListZone(_ delegate: ListZoneDelegate, villageId: Int?) {
        guard let villageId = villageId else {
            delegate.onRequestListZoneError(title: "Error", message: "Message Error")
            return
        }
        let token = StringUtils.getTokenHeader(token: (ShareData.userData?.token)!)
        let listZoneUrl = (ShareData.generic?.listZoneUrl)! + "\(villageId)/"
        let headers: HTTPHeaders = [
            "Authorization": token,
            ]
        Alamofire.request(listZoneUrl, method: .get,  headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success:
                do {
                    let listZoneResponse = try JSONDecoder().decode(ListZoneResponse.self, from: response.data!)
                    if (listZoneResponse.status! == ApiConstants.SUCCESS) {
                        delegate.onRequestListZoneSuccess(response: listZoneResponse)
                    } else {
                        delegate.onRequestListZoneFail(response: listZoneResponse)
                    }
                } catch {
                    print(error) // any decoding error will be printed here!
                }
            case .failure:
                delegate.onRequestListZoneError(title: "Error", message: "Message Error")
            }
        }
    }
}

public protocol ListZoneDelegate {
    func onRequestListZoneSuccess(response: ListZoneResponse)
    func onRequestListZoneFail(response: ListZoneResponse)
    func onRequestListZoneError(title: String, message: String)
}
