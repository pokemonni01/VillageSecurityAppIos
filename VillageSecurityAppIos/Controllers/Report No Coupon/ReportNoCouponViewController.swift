//
//  ReportNoCouponViewController.swift
//  Secure A
//
//  Created by Wachirapong on 23/10/2561 BE.
//  Copyright © 2561 Wachirapong. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

class ReportNoCouponViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var homeIdText: UITextField!
    @IBOutlet weak var carIdText: UITextField!
    @IBOutlet weak var carColorText: UITextField!
    @IBOutlet weak var carBrandText: UITextField!
    
    var homeNumberList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.homeIdText.delegate = self
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

    @IBAction func sendData(_ sender: Any) {
        let alert: UIAlertController
        guard let homeId = homeIdText.text, !homeId.isEmpty else {
            alert = UIAlertController(title: "เกิดข้อผิดพลาด", message: "ไม่พบหมายเลขบ้าน", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        guard let carId = carIdText.text, !carId.isEmpty else {
            alert = UIAlertController(title: "เกิดข้อผิดพลาด", message: "carIdText ว่าง", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        guard let carColor = carColorText.text, !carColor.isEmpty else {
            alert = UIAlertController(title: "เกิดข้อผิดพลาด", message: "carColorText ว่าง", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        guard let carBrand = carBrandText.text, !carBrand.isEmpty else {
            alert = UIAlertController(title: "เกิดข้อผิดพลาด", message: "carBrandText ว่าง", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
    }
}
