//
//  SplashScreenViewController.swift
//  VillageSecurityAppIos
//
//  Created by  Wachirapong Prasertwong on 3/1/2561 BE.
//  Copyright © 2561 Wachirapong. All rights reserved.
//

import UIKit
import Alamofire

class SplashScreenViewController: UIViewController {
    
    @IBOutlet weak var mProgress: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mProgress.startAnimating()
        mProgress.hidesWhenStopped = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadGeneric()
    }
    
    func loadGeneric() {
        GenericApi.getGeneric(delegate: self)
    }
}

extension SplashScreenViewController: GenericDelegate {
    
    func onGetGenericSuccess(generic: Generic) {
        self.mProgress.stopAnimating()
        ShareData.generic = generic
        let userData = UserDefaultsUtils.getUserData()
        if userData != nil {
            ShareData.userData = userData
            print(userData!)
        } else {
            let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.present(loginViewController, animated: true)
        }
    }
    
    func onGetGenericFail(generic: Generic) {
        print(generic)
    }
    
    func onGetGenericError(title: String, message: String) {
        print(title+" "+message)
    }
    
    
}
