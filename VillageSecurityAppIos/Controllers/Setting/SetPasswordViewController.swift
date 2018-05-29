//
//  SetPasswordViewController.swift
//  VillageSecurityAppIos
//
//  Created by Wachiraphong Prasoetwong on 23/5/2561 BE.
//  Copyright © 2561 Wachirapong. All rights reserved.
//

import UIKit

class SetPasswordViewController: BaseViewController, SetPasswordDelegate {
    
    @IBOutlet var rootView: UIView!
    @IBOutlet weak var currentPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmNewPasswordTextField: UITextField!
    @IBOutlet weak var setPasswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "เปลี่ยนรหัสผ่าน"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func setPassword(_ sender: Any) {
        guard let currentPassword = currentPasswordTextField.text, !currentPassword.isEmpty else {
            showAlertDialog(title: "", message: "")
            return
        }
        guard let newPassword = newPasswordTextField.text, !newPassword.isEmpty else {
            showAlertDialog(title: "", message: "")
            return
        }
        guard let confirmNewPassword = confirmNewPasswordTextField.text, !confirmNewPassword.isEmpty else {
            showAlertDialog(title: "", message: "")
            return
        }
        showProgress()
        SetPasswordAPI.requestSetPassword(self, currentPassword, newPassword)
    }
    
    func onRequestSetPasswordSuccess(response: SetPasswordResponse) {
        hideProgress()
        showAlertDialog(title: response.title ?? "", message: response.message ?? "")
        clearAllTextField()
    }
    
    func onRequestSetPasswordFail(response: SetPasswordResponse) {
        hideProgress()
        showAlertDialog(title: response.title ?? "", message: response.message ?? "")
        clearAllTextField()
    }
    
    func onRequestSetPasswordError(title: String, message: String) {
        hideProgress()
    }
    
    private func clearAllTextField() {
        currentPasswordTextField.clearText()
        newPasswordTextField.clearText()
        confirmNewPasswordTextField.clearText()
    }
}
