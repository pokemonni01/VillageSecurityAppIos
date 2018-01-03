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
        Alamofire.request(Config.baseURL).validate().responseJSON { response in
            switch response.result {
            case .success:
                self.mProgress.stopAnimating()
                let jsonDecoder = JSONDecoder()
                ShareData.generic = try! jsonDecoder.decode(Generic.self, from: response.data!)
                let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                self.present(loginViewController, animated: true)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
