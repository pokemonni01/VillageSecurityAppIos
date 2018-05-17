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

class WorkHistoryViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var mDatePicker: UITextField!
    @IBOutlet weak var mVillagePicker: UITextField!
    @IBOutlet weak var mZonePicker: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var rootView: UIView!
    
    private var mVillages: [Village]?
    private var mZones: [Zone]?
    private var mZoneNames = [String]()
    private var mGuard : [Guard]?
    
    private let mViewControllerUtils : ViewControllerUtils = ViewControllerUtils()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mVillagePicker.delegate = self
        self.mZonePicker.delegate = self
        self.mDatePicker.delegate = self
//        mZoneNames.append("ทั้งหมด")
        loadVillageList()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func loadVillageList() {
        mViewControllerUtils.showActivityIndicator(uiView: rootView)
        ListVillageApi.requestListVillage(self)
    }
    
    func loadZoneList(villageId: Int?) {
        mViewControllerUtils.showActivityIndicator(uiView: rootView)
        ListZoneApi.requestListZone(self, villageId: villageId)
    }
    
    func loadHistoryGuardList(villageId: Int?, zoneId: Int?, date: String) {
        mViewControllerUtils.showActivityIndicator(uiView: rootView)
        ListHistoryGuardAPI.requestListHistoryGuard(self, villageId: villageId, zoneId: zoneId, date: date)
    }

    func loadHistoryGuardList() {
        let villageId = mVillages!.first(where: { (village) -> Bool in
            village.name == mVillagePicker.text
        })!.pk!
        let zoneId = mZones!.first(where: { (zone) -> Bool in
            zone.name == mZonePicker.text
        })!.pk!
        let date = mDatePicker.text ?? DateTimeUtils.getCurrentDate()
        loadHistoryGuardList(villageId: villageId, zoneId: zoneId, date: date)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onDatePickerClick(_ sender: Any) {
        let datePicker = ActionSheetDatePicker(title: "เลือกวันที่", datePickerMode: UIDatePickerMode.date, selectedDate: DateTimeUtils.getDateFromString(date: mDatePicker.text), doneBlock: {
            picker, value, index in
            self.mDatePicker.endEditing(true)
            self.mDatePicker.text = DateTimeUtils.getDateString(date: value as! Date)
            self.loadHistoryGuardList()
            return
        }, cancel: { ActionStringCancelBlock in return }, origin: (sender as AnyObject).superview!?.superview)
        datePicker?.show()
    }
   
    @IBAction func onZonePickerClick(_ sender: Any) {
        ActionSheetStringPicker.show(withTitle: "เลือกเขต", rows: mZoneNames, initialSelection: 0, doneBlock: {
            picker, indexes, values in
            self.mZonePicker.endEditing(true)
            self.mZonePicker.text = values as? String
            self.loadHistoryGuardList()
            return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)
    }
    
    @IBAction func onVillagePickerClick(_ sender: Any) {
        ActionSheetStringPicker.show(withTitle: "เลือกหมู่บ้าน", rows: mVillages?.map({ (village: Village) -> String in
            village.name!
        }), initialSelection: 0, doneBlock: {
            picker, indexes, values in
            self.mVillagePicker.endEditing(true)
            self.mVillagePicker.text = values as? String
            return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mGuard?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "WorkHistoryTableViewCell"
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! WorkHistoryTableViewCell
        let mGuard = self.mGuard![indexPath.row]
        if (mGuard.status == "YES") {
            cell.statusImage.image = UIImage(named: "Green Dot")
        }
        cell.name.text = mGuard.first_name ?? ""
        cell.lastName.text = mGuard.last_name ?? ""
        cell.side.text = mGuard.type_guard?.name ?? ""
        cell.time.text = "เวลา : "+(mGuard.shift?.name ?? "")
        
        let zone = mGuard.zone?.number ?? -99
        if (zone == -99) {
            cell.mZone.text = "เขต : ไม่มี"
        } else {
            cell.mZone.text = "เขต : "+String(zone)
        }
        cell.selectionStyle = .none
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        let listJobHistoryViewController = self.storyboard?.instantiateViewController(withIdentifier: "ListJobHistoryViewController") as! ListJobHistoryViewController
        listJobHistoryViewController.mGuard = self.mGuard![indexPath.row]
        self.navigationController?.pushViewController(listJobHistoryViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.backgroundColor = UIColor.lightGray
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.backgroundColor = UIColor.white
    }
}

extension WorkHistoryViewController: ListVillageDelegate {
    func onRequestListVillageSuccess(response: ListVillageResponse) {
        mViewControllerUtils.hideActivityIndicator(uiView: rootView)
        mVillages = response.village
        mVillagePicker.text = mVillages?.first?.name
        print(response)
        loadZoneList(villageId: mVillages?.first?.pk)
    }
    
    func onRequestListVillageFail(response: ListVillageResponse) {
        mViewControllerUtils.hideActivityIndicator(uiView: rootView)
        print(response)
    }
    
    func onRequestListVillageError(title: String, message: String) {
        mViewControllerUtils.hideActivityIndicator(uiView: rootView)
        print(title+" "+message)
    }
}

extension WorkHistoryViewController: ListZoneDelegate {
    func onRequestListZoneSuccess(response: ListZoneResponse) {
        mViewControllerUtils.hideActivityIndicator(uiView: rootView)
        mZones = response.zone
        mZoneNames += mZones!.map({ (zone: Zone) -> String in
            zone.name!
        })
        mZonePicker.text = mZoneNames.first
        mDatePicker.text = DateTimeUtils.getCurrentDate()
        let villageIndex = mVillages?.index(where: { (village) -> Bool in
            village.name == mVillagePicker.text
        })
        loadHistoryGuardList(villageId: villageIndex, zoneId: mZones?.first?.pk, date: DateTimeUtils.getCurrentDate())
        print(response)
    }
    
    func onRequestListZoneFail(response: ListZoneResponse) {
        mViewControllerUtils.hideActivityIndicator(uiView: rootView)
        print(response)
    }
    
    func onRequestListZoneError(title: String, message: String) {
        mViewControllerUtils.hideActivityIndicator(uiView: rootView)
        print(title+" "+message)
    }
}

extension WorkHistoryViewController: ListHistoryGuardDelegate {
    func onRequestListHistoryGuardSuccess(response: ListHistoryGuardResponse) {
        mViewControllerUtils.hideActivityIndicator(uiView: rootView)
        mGuard = response.mGuard
        tableView.reloadData()
        print(response)
    }
    
    func onRequestListHistoryGuardFail(response: ListHistoryGuardResponse) {
        mViewControllerUtils.hideActivityIndicator(uiView: rootView)
        print(response)
    }
    
    func onRequestListHistoryGuardError(title: String, message: String) {
        mViewControllerUtils.hideActivityIndicator(uiView: rootView)
        print(title+" "+message)
    }
}
