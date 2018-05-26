//
//  NotificationDetailViewController.swift
//  VillageSecurityAppIos
//
//  Created by Wachiraphong Prasoetwong on 12/3/2561 BE.
//  Copyright © 2561 Wachirapong. All rights reserved.
//

import Foundation
import UIKit

class NotificationDetailViewController: BaseViewController, RequestNotificationDetailDelegate {
    
    private var notic: Notic?
    
    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var annotationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.isHidden = true
        loadNotification()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setNotic(notic: Notic) {
        self.notic = notic
    }
    
    private func loadNotification() {
        showProgress()
        NotificationAPI.requestNotificationDetail(self, noticId: notic?.pk)
    }
    
    func onRequestNotificationDetailSuccess(response: Notic) {
        hideProgress()
        rootView.isHidden = false
        titleLable.text = response.title ?? ""
        dateLabel.text = "วันที่ \(response.time ?? "") น."
        annotationLabel.text = response.detail ?? ""
    }
    
    func onRequestNotificationDetailFail(response: Notic) {
        hideProgress()
        showAlertDialog(title: response.title ?? "", message: response.message ?? "")
    }
    
    func onRequestNotificationDetailError() {
        hideProgress()
        showDefaultErrorDialog()
    }
}
