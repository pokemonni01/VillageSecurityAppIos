//
//  GenericApi.swift
//  VillageSecurityAppIos
//
//  Created by Wachirapong on 6/1/2561 BE.
//  Copyright © 2561 Wachirapong. All rights reserved.
//

import Foundation
import Alamofire

public class GenericApi {
    
    public static func getGeneric(delegate: GenericDelegate) {
        let url = Bundle.main.infoDictionary?["Generic URL"] as? String
        print("Generic Url : \(url ?? "")")
        Alamofire.request(url!).validate().responseJSON { response in
            switch response.result {
            case .success:
                delegate.onGetGenericSuccess(generic: try! JSONDecoder().decode(Generic.self, from: response.data!))
            case .failure:
                delegate.onGetGenericError(title: "Error", message: "Message Error")
            }
        }
    }
    
}

