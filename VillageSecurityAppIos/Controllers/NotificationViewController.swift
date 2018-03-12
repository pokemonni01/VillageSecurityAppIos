//
//  NotificationViewController.swift
//  VillageSecurityAppIos
//
//  Created by Wachiraphong Prasoetwong on 8/2/2561 BE.
//  Copyright © 2561 Wachirapong. All rights reserved.
//

import Foundation
import UIKit

class NotificationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var tableView: UITableView!
    
    let animals: [String] = ["Horse", "Cow", "Camel", "Sheep", "Goat"]
    
    // cell reuse id (cells that scroll out of view can be reused)
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.animals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: IdentifierNames.cellReuseIdentifier) as! NotificationTableViewCell
        cell.titleLabel?.text = self.animals[indexPath.row]
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        goToNotificationDetailPage()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func goToNotificationDetailPage() {
        let notificationDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: IdentifierNames.notificationDetailViewController) as! NotificationDetailViewController
        self.navigationController?.pushViewController(notificationDetailViewController, animated: true)
    }
    
}
