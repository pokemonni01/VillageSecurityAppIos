//
//  HistoryCarViewController.swift
//  VillageSecurityAppIos
//
//  Created by Wachirapong on 27/5/2561 BE.
//  Copyright © 2561 Wachirapong. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

class HistoryCarViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var villageLabel: UITextField!
    @IBOutlet weak var dateLabel: UITextField!
    @IBOutlet weak var noDataLabel: UILabel!
    
    private var mVillages = [Village]()
    private var mQrCodes = [QrCode]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.villageLabel.delegate = self
        self.dateLabel.delegate = self
        dateLabel.text = DateTimeUtils.getCurrentDate()
        loadVillage()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func loadVillage() {
        showProgress()
        ListVillageApi.requestListVillage(self)
    }
    
    private func loadHistoryCarList() {
        if ( (villageLabel.text ?? "").isEmpty || (dateLabel.text ?? "").isEmpty ) {
            return
        }
        showProgress()
        let villageId = mVillages.first(where: { (village) -> Bool in
            village.name == villageLabel.text
        })!.pk!
        guard let date = dateLabel.text else {
            return
        }
        HistoryCarAPI.requestNotificationList(self, villageId: villageId, time: date)
    }
    
    @IBAction func onVillagePickerClick(_ sender: Any) {
        ActionSheetStringPicker.show(withTitle: "เลือกหมู่บ้าน", rows: mVillages.map({ (village: Village) -> String in
            village.name!
        }), initialSelection: 0, doneBlock: {
            picker, indexes, values in
            self.villageLabel.text = values as? String
            self.villageLabel.endEditing(true)
            self.loadHistoryCarList()
            return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)
    }
    
    @IBAction func onDatePickerClick(_ sender: Any) {
        let datePicker = ActionSheetDatePicker(title: "เลือกวันที่", datePickerMode: UIDatePickerMode.date, selectedDate: DateTimeUtils.getDateFromString(date: dateLabel.text), doneBlock: {
            picker, value, index in
            self.dateLabel.text = DateTimeUtils.getDateString(date: value as! Date)
            self.dateLabel.endEditing(true)
            self.loadHistoryCarList()
            return
        }, cancel: { ActionStringCancelBlock in return }, origin: (sender as AnyObject).superview!?.superview)
        datePicker?.show()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mQrCodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "HistoryCarTableViewCell"
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! HistoryCarTableViewCell
        let qrCode = mQrCodes[indexPath.row]
        var numberCar = "-"
        if !qrCode.numberCar.isEmpty {
            numberCar = qrCode.numberCar
        }
        var homeNumber = "-"
        if !(qrCode.home?.number?.isEmpty)! {
            homeNumber = qrCode.home?.number ?? "-"
        }
        let position = mQrCodes.count - indexPath.row
        cell.titleLabel.text = "คันที่ : \(position) รถ : \(numberCar) บ้าน : \(homeNumber)"
        if !qrCode.timeIn.isEmpty {
            cell.getInLabel.text = "เข้า : \(qrCode.timeIn)"
        }
        if !qrCode.timeOut.isEmpty {
            cell.getOutLabel.text = "ออก : \(qrCode.timeOut)"
        }
        if !qrCode.timeGuard.isEmpty {
            cell.guardScanLabel.text = "รปภ. แสกน : \(qrCode.timeGuard)"
        }
        if !qrCode.timeUser.isEmpty {
            cell.userScanLabel.text = "ลูกบ้านแสกน : \(qrCode.timeUser)"
        }
        
        if (qrCode.codeStatus == "2") {
            cell.statusImage.image = UIImage(named: "Green Dot")
        } else if (qrCode.codeStatus == "1") {
            cell.statusImage.image = UIImage(named: "Orange Dot")
        } else {
            cell.statusImage.image = UIImage(named: "Red Dot")
            if (qrCode.statusUser == "YES"){
                cell.statusImage.image = UIImage(named: "Blue Dot")
            } else if (qrCode.statusGuard == "OK") {
                cell.statusImage.image = UIImage(named: "Brown Dot")
            }
        }
        cell.selectionStyle = .none
        return cell
    }
    
    private func showNoData() {
        tableView.isHidden = true
        noDataLabel.isHidden = false
    }
    
    private func hideNoData() {
        tableView.isHidden = false
        noDataLabel.isHidden = true
    }

}

extension HistoryCarViewController : ListVillageDelegate {
    
    func onRequestListVillageSuccess(response: ListVillageResponse) {
        hideProgress()
        self.mVillages = response.village ?? [Village]()
        if (self.mVillages.count == 0) {
            showNoData()
            return
        }
        hideNoData()
        villageLabel.text = self.mVillages.first?.name ?? ""
        loadHistoryCarList()
    }
    
    func onRequestListVillageFail(response: ListVillageResponse) {
        hideProgress()
        showNoData()
        showAlertDialog(title: response.title ?? "", message: response.message ?? "")
    }
    
    func onRequestListVillageError(title: String, message: String) {
        hideProgress()
        showNoData()
    }
}

extension HistoryCarViewController : RequestHistoryCarListDelegate {
    func onRequestHistoryCarListSuccess(response: HistoryCarResponse) {
        hideProgress()
        self.mQrCodes = response.qrcodes ?? [QrCode]()
        if (self.mQrCodes.count == 0) {
            showNoData()
        } else {
           hideNoData()
        }
        tableView.reloadData()
    }
    
    func onRequestHistoryCarListFail(response: HistoryCarResponse) {
        hideProgress()
        showNoData()
        showAlertDialog(title: response.title ?? "", message: response.message ?? "")
    }
    
    func onRequestHistoryCarListError() {
        hideProgress()
        showNoData()
        showDefaultErrorDialog()
    }
}
