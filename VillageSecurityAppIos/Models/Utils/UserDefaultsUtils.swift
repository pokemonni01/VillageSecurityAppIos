//
//  UserDefaultsUtils.swift
//  VillageSecurityAppIos
//
//  Created by Wachiraphong Prasoetwong on 15/2/2561 BE.
//  Copyright © 2561 Wachirapong. All rights reserved.
//

import Foundation

class UserDefaultsUtils {
    static func saveUserData(userdata: UserData) {
        let preferences = UserDefaults.standard
        let userDataKey = "UserData"
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(userdata) {
            print(encoded)
            preferences.set(encoded, forKey: userDataKey)
            preferences.synchronize()
        }
    }
    
    static func getUserData() -> UserData? {
        let userDataKey = "UserData"
        let decoder = JSONDecoder()
        if let rawUserData = UserDefaults.standard.data(forKey: userDataKey), let userData = try? decoder.decode(UserData.self, from: rawUserData) {
            return userData
        }
        return nil
    }
    
    static func removeUserData() {
        let preferences = UserDefaults.standard
        let userDataKey = "UserData"
        preferences.removeObject(forKey: userDataKey)
        preferences.synchronize()
    }
}
