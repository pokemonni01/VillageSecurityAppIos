//
//  ViewController.swift
//  VillageSecurityAppIos
//
//  Created by Wachirapong on 25/12/2560 BE.
//  Copyright © 2560 Wachirapong. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var mUsernameTextField: UITextField!
    
    @IBOutlet weak var mPasswordTextField: UITextField!

    @IBOutlet var mRootView: UIView!
    
    @IBAction func login(_ sender: UIButton) {
        let username = mUsernameTextField.text!
        let password = mPasswordTextField.text!
        login(username: username, password: password)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func login(username: String, password: String) {
        showProgress()
        LoginApi.requestLogin(self, username, password)
    }
    
}

extension LoginViewController: LoginDelegate {
    func onRequestLoginSuccess(response: LoginResponse) {
        hideProgress()
        let userMenuViewController = self.storyboard?.instantiateViewController(withIdentifier: IdentifierNames.userMenuNavigationViewController) as! UINavigationController
        self.present(userMenuViewController, animated: true)
        let userData = UserData(
            username: response.username!,
            detail: response.detail!,
            token: response.token!
        )
        ShareData.userData = userData
        UserDefaultsUtils.saveUserData(userdata: userData)
        print(response)
    }
    
    func onRequestLoginFail(response: LoginResponse) {
        hideProgress()
        let title = response.title!
        let message = response.message!
        showAlertDialog(title: title, message: message)
        print(response)
    }
    
    func onRequestLoginError(title: String, message: String) {
        hideProgress()
        showDefaultErrorDialog()
    }    
}

