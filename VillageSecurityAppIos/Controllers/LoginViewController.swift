//
//  ViewController.swift
//  VillageSecurityAppIos
//
//  Created by Wachirapong on 25/12/2560 BE.
//  Copyright © 2560 Wachirapong. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
    
    @IBOutlet weak var mUsernameTextField: UITextField!
    
    @IBOutlet weak var mPasswordTextField: UITextField!
    
    
    @IBAction func login(_ sender: UIButton) {
        let username = mUsernameTextField.text!
        let password = mPasswordTextField.text!
        LoginApi.requestLogin(self, username, password)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


extension LoginViewController: LoginDelegate {
    func onRequestLoginSuccess(response: LoginResponse) {
        print(response)
    }
    
    func onRequestLoginFail(response: LoginResponse) {
        print(response)
    }
    
    func onRequestLoginError(title: String, message: String) {
        print(title+" "+message)
    }    
}

