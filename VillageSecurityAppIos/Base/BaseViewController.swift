//
//  BaseViewController.swift
//  VillageSecurityAppIos
//
//  Created by Wachiraphong Prasoetwong on 23/5/2561 BE.
//  Copyright © 2561 Wachirapong. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    let mViewControllerUtils : ViewControllerUtils = ViewControllerUtils()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showProgress() {
        mViewControllerUtils.showActivityIndicator(uiView: view)
    }
    func hideProgress() {
        mViewControllerUtils.hideActivityIndicator(uiView: view)
    }
    
    func showAlertDialog(title: String, message: String) {
        mViewControllerUtils.showAlertDialogOneButton(viewController: self, title: title, message: message)
    }
    
    func showDefaultErrorDialog() {
        let title = "ไม่สามารถติดต่อระบบได้"
        let message = "ไม่สามารถติดต่อระบบได้ กรุณาลองใหม่ในภายหลัง"
        showAlertDialog(title: title, message: message)
    }
}
