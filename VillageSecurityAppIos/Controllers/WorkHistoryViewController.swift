//
//  WorkHistoryViewController.swift
//  VillageSecurityAppIos
//
//  Created by Wachiraphong Prasoetwong on 12/3/2561 BE.
//  Copyright © 2561 Wachirapong. All rights reserved.
//

import Foundation
import UIKit
import ActionSheetPicker_3_0

class WorkHistoryViewController: UIViewController {
    
    @IBOutlet weak var mTimePicker: UITextField!
    @IBOutlet weak var mDatePicker: UITextField!
    @IBOutlet weak var mBorderPicker: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mTimePicker.tintColor = .clear
        mDatePicker.tintColor = .clear
        mBorderPicker.tintColor = .clear
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onTimePickerClick(_ sender: Any) {
        ActionSheetStringPicker.show(withTitle: "เลือกเวลา", rows: ["1 ชั่วโมงก่อนหน้า", "2 ชั่วโมงก่อนหน้า", "3 ชั่วโมงก่อนหน้า"], initialSelection: 0, doneBlock: {
            picker, indexes, values in
            
            print("values = \(String(describing: values))")
            print("indexes = \(String(describing: indexes))")
            print("picker = \(String(describing: picker))")
            self.mTimePicker.endEditing(true)
            self.mTimePicker.text = values as? String
            return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)
    }
    
    @IBAction func onDatePickerClick(_ sender: Any) {
        let datePicker = ActionSheetDatePicker(title: "เลือกวันที่", datePickerMode: UIDatePickerMode.date, selectedDate: Date(), doneBlock: {
            picker, value, index in
            
            print("value = \(String(describing: value))")
            print("index = \(String(describing: index))")
            print("picker = \(String(describing: picker))")
            self.mDatePicker.endEditing(true)
            self.mDatePicker.text = value as? String
            return
        }, cancel: { ActionStringCancelBlock in return }, origin: (sender as AnyObject).superview!?.superview)
//        let secondsInWeek: TimeInterval = 7 * 24 * 60 * 60;
//        datePicker?.minimumDate = Date(timeInterval: -secondsInWeek, since: Date())
//        datePicker?.maximumDate = Date(timeInterval: secondsInWeek, since: Date())
        datePicker?.show()
    }
    
    @IBAction func onBorderClick(_ sender: Any) {
        ActionSheetStringPicker.show(withTitle: "เลือกเขต", rows: ["1 ชั่วโมงก่อนหน้า", "2 ชั่วโมงก่อนหน้า", "3 ชั่วโมงก่อนหน้า"], initialSelection: 0, doneBlock: {
            picker, indexes, values in
            
            print("values = \(String(describing: values))")
            print("indexes = \(String(describing: indexes))")
            print("picker = \(String(describing: picker))")
            self.mTimePicker.endEditing(true)
            self.mTimePicker.text = values as? String
            return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)
       
    }
}
