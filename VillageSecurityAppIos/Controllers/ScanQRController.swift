//
//  ScanQRController.swift
//  VillageSecurityAppIos
//
//  Created by Wachirapong on 22/1/2561 BE.
//  Copyright © 2561 Wachirapong. All rights reserved.
//
import AVFoundation
import QRCodeReader
import UIKit

class ScanQRController: UIViewController {
    
    @IBOutlet weak var previewView: QRCodeReaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
