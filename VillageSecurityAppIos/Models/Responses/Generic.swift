//
//  Generic.swift
//  VillageSecurityAppIos
//
//  Created by Wachirapong on 30/12/2560 BE.
//  Copyright © 2560 Wachirapong. All rights reserved.
//

import Foundation

public struct Generic : Codable {
    let scanCodeUrl : String?
    let listHomeUrl : String?
    let checkPointUrl : String?
    let listCheckCarUrl : String?
    let listGuardBehaviorUrl : String?
    let listGuardUrl : String?
    let listPointUrl : String?
    let singUpGuardUrl : String?
    let deleteGuardUrl : String?
    let deletePointUrl : String?
    let listZoneUrl : String?
    let typeUserUrl : String?
    let singInUserUrl : String?
    let deviceUrl : String?
    let listHistoryGuardUrl : String?
    let listVillageUrl : String?
    let singInGuardUrl : String?
    let typeGuardUrl : String?
    let jopGuardUrl : String?
    let historyGuardUrl : String?
    let mainUrl : String?
    let singUpUserUrl : String?
    
    enum CodingKeys: String, CodingKey {
        
        case scanCodeUrl = "scanCodeUrl"
        case listHomeUrl = "listHomeUrl"
        case checkPointUrl = "checkPointUrl"
        case listCheckCarUrl = "listCheckCarUrl"
        case listGuardBehaviorUrl = "listGuardBehaviorUrl"
        case listGuardUrl = "listGuardUrl"
        case listPointUrl = "listPointUrl"
        case singUpGuardUrl = "singUpGuardUrl"
        case deleteGuardUrl = "deleteGuardUrl"
        case deletePointUrl = "deletePointUrl"
        case listZoneUrl = "listZoneUrl"
        case typeUserUrl = "typeUserUrl"
        case singInUserUrl = "singInUserUrl"
        case deviceUrl = "deviceUrl"
        case listHistoryGuardUrl = "listHistoryGuardUrl"
        case listVillageUrl = "listVillageUrl"
        case singInGuardUrl = "singInGuardUrl"
        case typeGuardUrl = "typeGuardUrl"
        case jopGuardUrl = "jopGuardUrl"
        case historyGuardUrl = "historyGuardUrl"
        case mainUrl = "mainUrl"
        case singUpUserUrl = "singUpUserUrl"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        scanCodeUrl = try values.decodeIfPresent(String.self, forKey: .scanCodeUrl)
        listHomeUrl = try values.decodeIfPresent(String.self, forKey: .listHomeUrl)
        checkPointUrl = try values.decodeIfPresent(String.self, forKey: .checkPointUrl)
        listCheckCarUrl = try values.decodeIfPresent(String.self, forKey: .listCheckCarUrl)
        listGuardBehaviorUrl = try values.decodeIfPresent(String.self, forKey: .listGuardBehaviorUrl)
        listGuardUrl = try values.decodeIfPresent(String.self, forKey: .listGuardUrl)
        listPointUrl = try values.decodeIfPresent(String.self, forKey: .listPointUrl)
        singUpGuardUrl = try values.decodeIfPresent(String.self, forKey: .singUpGuardUrl)
        deleteGuardUrl = try values.decodeIfPresent(String.self, forKey: .deleteGuardUrl)
        deletePointUrl = try values.decodeIfPresent(String.self, forKey: .deletePointUrl)
        listZoneUrl = try values.decodeIfPresent(String.self, forKey: .listZoneUrl)
        typeUserUrl = try values.decodeIfPresent(String.self, forKey: .typeUserUrl)
        singInUserUrl = try values.decodeIfPresent(String.self, forKey: .singInUserUrl)
        deviceUrl = try values.decodeIfPresent(String.self, forKey: .deviceUrl)
        listHistoryGuardUrl = try values.decodeIfPresent(String.self, forKey: .listHistoryGuardUrl)
        listVillageUrl = try values.decodeIfPresent(String.self, forKey: .listVillageUrl)
        singInGuardUrl = try values.decodeIfPresent(String.self, forKey: .singInGuardUrl)
        typeGuardUrl = try values.decodeIfPresent(String.self, forKey: .typeGuardUrl)
        jopGuardUrl = try values.decodeIfPresent(String.self, forKey: .jopGuardUrl)
        historyGuardUrl = try values.decodeIfPresent(String.self, forKey: .historyGuardUrl)
        mainUrl = try values.decodeIfPresent(String.self, forKey: .mainUrl)
        singUpUserUrl = try values.decodeIfPresent(String.self, forKey: .singUpUserUrl)
    }
    
}
