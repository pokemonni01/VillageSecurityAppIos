//
//  UserDefaultsUtils.swift
//  VillageSecurityAppIos
//
//  Created by Wachiraphong Prasoetwong on 15/2/2561 BE.
//  Copyright © 2561 Wachirapong. All rights reserved.
//

import Foundation

class UserDefaultsUtils {
    static func setUserData() {
        let preferences = UserDefaults.standard
        let currentLevelKey = "UserData"
        let currentLevel = 2
        preferences.set(currentLevel, forKey: currentLevelKey)
        //  Save to disk
        let didSave = preferences.synchronize()
        if !didSave {
            //  Couldn't save (I've never seen this happen in real world testing)
        }
    }
}
