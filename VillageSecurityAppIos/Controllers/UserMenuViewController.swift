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

class UserMenuViewController: BaseViewController, SettingDelegate, RequestNotificationListDelegate {

    @IBOutlet weak var notificationFrame: UIView!
    @IBOutlet weak var notificationNumberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Secure A"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadSetting()
    }
    
    private func loadSetting() {
        showProgress()
        SettingAPI.requestSetting(self)
    }
    
    func onRequestSettingSuccess(response: SettingResponse) {
        hideProgress()
        ShareData.setting = response
        loadNotification()
    }
    
    func onRequestSettingError() {
        hideProgress()
        showDefaultErrorDialog()
    }
    
    private func loadNotification() {
        showProgress()
        NotificationAPI.requestNotificationList(self)
    }
    
    func onRequestNotificationListSuccess(response: GetNotificationResponse) {
        hideProgress()
        guard let notificationNumber = response.countNotRead else {
            notificationFrame.isHidden = true
            return
        }
        if (notificationNumber == 0) {
            notificationFrame.isHidden = true
        } else {
            notificationFrame.isHidden = false
            notificationNumberLabel.text = String(notificationNumber)
        }
    }
    
    func onRequestNotificationListFail(response: GetNotificationResponse) {
        hideProgress()
        showAlertDialog(title: response.title ?? "", message: response.message ?? "")
    }
    
    func onRequestNotificationListError() {
        hideProgress()
        showDefaultErrorDialog()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onGoToScanQRClick(_ sender: Any) {
        guard checkScanPermissions() else { return }
        let scanQRController = self.storyboard?.instantiateViewController(withIdentifier: IdentifierNames.scanQRController) as! ScanQRController
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
    
    @IBAction func onLogoutClick(_ sender: Any) {
        DeviceApi.sendDevice(self, ShareData.userData?.username ?? "", false)
        UserDefaultsUtils.removeUserData()
        self.dismiss(animated: true)
    }
}


extension UserMenuViewController: SendDeviceDelegate {
    func onSendDeviceSuccess(response: SendDeviceResponse) {}
    
    func onSendDeviceFail(response: SendDeviceResponse) {}
    
    func onSendDeviceError() {}
}

