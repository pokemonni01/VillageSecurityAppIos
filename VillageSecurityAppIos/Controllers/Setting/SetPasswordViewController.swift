//
//  SetPasswordViewController.swift
//  VillageSecurityAppIos
//
//  Created by Wachiraphong Prasoetwong on 23/5/2561 BE.
//  Copyright © 2561 Wachirapong. All rights reserved.
//

import UIKit

class SetPasswordViewController: BaseViewController, SetPasswordDelegate, UITextFieldDelegate {
    
    @IBOutlet var rootView: UIView!
    @IBOutlet weak var currentPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmNewPasswordTextField: UITextField!
    @IBOutlet weak var setPasswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "เปลี่ยนรหัสผ่าน"
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        currentPasswordTextField.delegate = self
        newPasswordTextField.delegate = self
        confirmNewPasswordTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Try to find next responder
        if textField == currentPasswordTextField {
            newPasswordTextField.becomeFirstResponder()
        } else if textField == newPasswordTextField {
            confirmNewPasswordTextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
            requestSetPassword()
        }
        // Do not add a line break
        return false
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        currentPasswordTextField.resignFirstResponder()
        newPasswordTextField.resignFirstResponder()
        confirmNewPasswordTextField.resignFirstResponder()
    }

    @IBAction func setPassword(_ sender: Any) {
        requestSetPassword()
    }
    
    private func requestSetPassword() {
        guard let currentPassword = currentPasswordTextField.text, !currentPassword.isEmpty else {
            showAlertDialog(title: "รหัสผ่านปัจจุบันไม่ถูกต้อง", message: "รหัสผ่านปัจจุบันไม่ถูกต้อง กรุณากรอกรหัสผ่านปัจจุบันอีกครั้ง")
            currentPasswordTextField.resignFirstResponder()
            currentPasswordTextField.text = ""
            return
        }
        guard let newPassword = newPasswordTextField.text, !newPassword.isEmpty else {
            showAlertDialog(title: "รหัสผ่านใหม่ไม่ถูกต้อง", message: "รหัสผ่านใหม่ไม่ถูกต้อง กรุณากรอกรหัสผ่านใหม่อีกครั้ง")
            newPasswordTextField.resignFirstResponder()
            newPasswordTextField.text = ""
            return
        }
        guard let confirmNewPassword = confirmNewPasswordTextField.text, !confirmNewPassword.isEmpty else {
            showAlertDialog(title: "ยืนยันรหัสผ่านใหม่ไม่ถูกต้อง", message: "ยืนยันรหัสผ่านใหม่ไม่ถูกต้อง  กรุณากรอกยืนยันรหัสผ่านใหม่อีกครั้ง")
            confirmNewPasswordTextField.resignFirstResponder()
            confirmNewPasswordTextField.text = ""
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
        showDefaultErrorDialog()
    }
    
    private func clearAllTextField() {
        currentPasswordTextField.clearText()
        newPasswordTextField.clearText()
        confirmNewPasswordTextField.clearText()
    }
}
