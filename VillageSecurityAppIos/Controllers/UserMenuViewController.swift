//
//  UserMenuViewController.swift
//  VillageSecurityAppIos
//
//  Created by Wachirapong on 8/1/2561 BE.
//  Copyright © 2561 Wachirapong. All rights reserved.
//
import UIKit
import Foundation

class UserMenuViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onGoToScanQRClick(_ sender: Any) {
        let scanQRController = self.storyboard?.instantiateViewController(withIdentifier: "ScanQRController") as! ScanQRController
        self.present(scanQRController, animated: true)
    }
}

