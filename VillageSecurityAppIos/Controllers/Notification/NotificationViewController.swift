//
//  NotificationViewController.swift
//  VillageSecurityAppIos
//
//  Created by Wachiraphong Prasoetwong on 8/2/2561 BE.
//  Copyright © 2561 Wachirapong. All rights reserved.
//

import Foundation
import UIKit

class NotificationViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, RequestNotificationListDelegate  {
    
    @IBOutlet weak var tableView: UITableView!

    private var notics = [Notic]()
    
    // cell reuse id (cells that scroll out of view can be reused)
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "รายการแจ้งเตือน"
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadNotificationList()
    }
    
    private func loadNotificationList() {
        showProgress()
        NotificationAPI.requestNotificationList(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.notics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCell") as! NotificationTableViewCell
        let notic = notics[indexPath.row]
        cell.titleNotification.text = notic.title
        if (notic.statusRead?.isReaded() ?? false) {
            cell.titleNotification.font = UIFont.systemFont(ofSize: 17.0)
        }
        cell.dateTimeNotification.text = "วันที่ \(notic.time ?? "") น."
        cell.selectionStyle = .none
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToNotificationDetailPage(notic: notics[indexPath.row])
    }
    
    func goToNotificationDetailPage(notic: Notic) {
        let notificationDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: IdentifierNames.notificationDetailViewController) as! NotificationDetailViewController
        notificationDetailViewController.setNotic(notic: notic)
        self.navigationController?.pushViewController(notificationDetailViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.backgroundColor = UIColor.lightGray
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.backgroundColor = UIColor.white
    }
    
    func onRequestNotificationListSuccess(response: GetNotificationResponse) {
        hideProgress()
        self.notics = response.notics ?? [Notic]()
        tableView.reloadData()
    }
    
    func onRequestNotificationListFail(response: GetNotificationResponse) {
        hideProgress()
        showAlertDialog(title: response.title ?? "", message: response.message ?? "")
    }
    
    func onRequestNotificationListError() {
        hideProgress()
        showDefaultErrorDialog()
    }
    
}

private extension String {
    func isReaded() -> Bool {
        return self == "YES"
    }
}
