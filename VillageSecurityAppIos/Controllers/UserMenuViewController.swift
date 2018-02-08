//
//  UserMenuViewController.swift
//  VillageSecurityAppIos
//
//  Created by Wachirapong on 8/1/2561 BE.
//  Copyright © 2561 Wachirapong. All rights reserved.
//
import UIKit
import QRCodeReader
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
        guard checkScanPermissions() else { return }
        let scanQRController = self.storyboard?.instantiateViewController(withIdentifier: "ScanQRController") as! ScanQRController
        self.navigationController?.pushViewController(scanQRController, animated: true)
    }
    
    private func checkScanPermissions() -> Bool {
        do {
            return try QRCodeReader.supportsMetadataObjectTypes()
        } catch let error as NSError {
            let alert: UIAlertController
            switch error.code {
            case -11852:
                alert = UIAlertController(title: "Error", message: "This app is not authorized to use Back Camera.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Setting", style: .default, handler: { (_) in
                    DispatchQueue.main.async {
                        if let settingsURL = URL(string: UIApplicationOpenSettingsURLString) {
                            UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
                        }
                    }
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            default:
                alert = UIAlertController(title: "Error", message: "Reader not supported by the current device", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            }
            present(alert, animated: true, completion: nil)
            return false
        }
    }
    
    @IBAction func onNotificationButtonClick(_ sender: Any) {
        let notificationViewController = self.storyboard?.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
        self.navigationController?.pushViewController(notificationViewController, animated: true)
    }
}

