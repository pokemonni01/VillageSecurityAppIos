//
//  ListVillageAPI.swift
//  VillageSecurityAppIos
//
//  Created by Wachiraphong Prasoetwong on 14/4/2561 BE.
//  Copyright © 2561 Wachirapong. All rights reserved.
//

import Foundation
import Alamofire

public class ListVillageApi {
    
    public static func requestListVillage(_ delegate: ListVillageDelegate) {
        let token = StringUtils.getTokenHeader(token: (ShareData.userData?.token)!)
        guard let userId = ShareData.userData?.detail?.pk else { delegate.onRequestListVillageError(title: "Error", message: "Message Error"); return }
        let listVillageUrl = (ShareData.generic?.listVillageUrl)! + "\(userId)/?type=user"
        let headers: HTTPHeaders = [
            "Authorization": token,
        ]
        Alamofire.request(listVillageUrl, method: .get,  headers: headers).validate().responseJSON { response in
            switch response.result {
                case .success:
                    do {
                        let listVillageResponse = try JSONDecoder().decode(ListVillageResponse.self, from: response.data!)
                        if (listVillageResponse.status! == ApiConstants.SUCCESS) {
                            delegate.onRequestListVillageSuccess(response: listVillageResponse)
                        } else {
                            delegate.onRequestListVillageFail(response: listVillageResponse)
                        }
                    } catch {
                        print(error) // any decoding error will be printed here!
                    }
                case .failure:
                    delegate.onRequestListVillageError(title: "Error", message: "Message Error")
            }
        }
    }
    
}

public protocol ListVillageDelegate {
    func onRequestListVillageSuccess(response: ListVillageResponse)
    func onRequestListVillageFail(response: ListVillageResponse)
    func onRequestListVillageError(title: String, message: String)
}
