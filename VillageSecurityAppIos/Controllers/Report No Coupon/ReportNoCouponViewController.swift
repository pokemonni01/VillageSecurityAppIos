//
//  ReportNoCouponViewController.swift
//  Secure A
//
//  Created by Wachirapong on 23/10/2561 BE.
//  Copyright © 2561 Wachirapong. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0
import CoreLocation

class ReportNoCouponViewController: BaseViewController, UITextFieldDelegate {
    
    @IBOutlet weak var homeIdText: UITextField!
    @IBOutlet weak var carIdText: UITextField!
    @IBOutlet weak var carColorText: UITextField!
    @IBOutlet weak var carBrandText: UITextField!
    
    var homeNumberList = [String]()
    var locManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locManager.requestWhenInUseAuthorization()
        self.homeIdText.delegate = self
        self.carIdText.delegate = self
        self.carColorText.delegate = self
        self.carBrandText.delegate = self
        setHomeList()
    }
    
    private func setHomeList() {

        guard let homeList = ShareData.userData?.detail?.home, !homeList.isEmpty else {
            let alert = UIAlertController(title: "เกิดข้อผิดพลาด", message: "ไม่พบหมายเลขบ้าน", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {
                (alert: UIAlertAction!) in self.navigationController?.popViewController(animated: true)
            }))
            present(alert, animated: true, completion: nil)
            return
        }
        for home in homeList {
            guard let number = home.number else {
                continue
            }
            homeNumberList.append(number)
        }
        homeIdText.text = homeNumberList[0]
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == homeIdText {
            return false
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Try to find next responder
        if textField == carIdText {
            carColorText.becomeFirstResponder()
        } else if textField == carColorText {
            carBrandText.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
            sendData()
        }
        // Do not add a line break
        return false
    }
    
    @IBAction func selectHomeNumber(_ sender: Any) {
        ActionSheetStringPicker.show(withTitle: "เลือกหมู่บ้าน", rows: homeNumberList, initialSelection: 0, doneBlock: {
            picker, indexes, values in
            self.homeIdText.text = values as? String
            self.homeIdText.endEditing(true)
            return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)
    }
    
    private func sendData() {
        let alert: UIAlertController
        guard let homeNumber = homeIdText.text, !homeNumber.isEmpty else {
            alert = UIAlertController(title: "เกิดข้อผิดพลาด", message: "ไม่พบหมายเลขบ้าน", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        guard let carId = carIdText.text, !carId.isEmpty else {
            alert = UIAlertController(title: "เกิดข้อผิดพลาด", message: "กรุณากรอกทะเบียนรถ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        let carColor = carColorText.text ?? ""
        let carBrand = carBrandText.text ?? ""
        var currentLocation: CLLocation!
        
        if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways){
            currentLocation = locManager.location
            showProgress()
            let lat = String(currentLocation.coordinate.latitude)
            let lon = String(currentLocation.coordinate.longitude)
            guard let homePk = ShareData.userData?.detail?.home?.filter({ (Home) -> Bool in
                Home.number == homeNumber
            }).first?.pk else {
                return
            }
            UserSendCarAPI.sendCarData(self, homeId: Int(homePk), carId: carId, carColor: carColor, carBrand: carBrand, lat: lat, lon: lon)
        } else {
            showAlertDialog(title: "ไม่สามารถส่งข้อมูลได้", message: "ไม่สามารถส่งข้อมูลได้ กรุณาเปิดใช้งานการระบุตำแหน่ง")
        }
    }

    @IBAction func sendData(_ sender: Any) {
        sendData()
    }
}

extension ReportNoCouponViewController : SendCarDataDelegate {
    
    func onSendCarDataSuccess(response: SendCarDataResponse) {
        hideProgress()
        let alert = UIAlertController(title: response.title ?? "", message: response.message ?? "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ตกลง", style: .cancel, handler: {
            (alert: UIAlertAction!) in self.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func onSendCarDataFail(response: SendCarDataResponse) {
        hideProgress()
        let alert = UIAlertController(title: response.title ?? "", message: response.message ?? "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ตกลง", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func onSendCarDataError() {
        hideProgress()
        showDefaultErrorDialog()
    }
}
