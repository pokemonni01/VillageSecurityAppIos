//
//  ViewController.swift
//  VillageSecurityAppIos
//
//  Created by Wachirapong on 25/12/2560 BE.
//  Copyright © 2560 Wachirapong. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBAction func login(_ sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        loadGeneric()
    }
    
    func loadGeneric() {
//        if (ShareData.generic) {
//
//        }
        Alamofire.request(Config.baseURL).validate().responseJSON { response in
            switch response.result {
            case .success:
                let jsonDecoder = JSONDecoder()
                ShareData.generic = try! jsonDecoder.decode(Generic.self, from: response.data!)
            case .failure(let error):
                print(error)
            }
        }
    }

}

