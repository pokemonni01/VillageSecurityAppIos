//
//  VersionViewController.swift
//  VillageSecurityAppIos
//
//  Created by Wachiraphong Prasoetwong on 24/5/2561 BE.
//  Copyright © 2561 Wachirapong. All rights reserved.
//

import UIKit

class VersionViewController: UIViewController {
    
    @IBOutlet weak var labelVersion: UILabel!
    @IBOutlet weak var labelLatestVersion: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let latestVersion = ShareData.setting?.versionApp ?? ""
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            labelVersion.text = "เวอร์ชัน \(version)"
        }
        labelLatestVersion.text = "เวอร์ชันล่าสุด \(latestVersion)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
