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

class ScanQRController: BaseViewController, AVCaptureMetadataOutputObjectsDelegate, SendQrCodeDataDelegate {

    var captureDevice:AVCaptureDevice?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    let captureSession = AVCaptureSession()
    var currentQr = ""
    
    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var noScanLabel: UILabel!
    @IBOutlet weak var scanSuccessLabel: UILabel!
    @IBOutlet weak var sendDataButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.title = "Scanner"
        cameraView.backgroundColor = .white
        
        captureDevice = AVCaptureDevice.default(for: .video)
        // Check if captureDevice returns a value and unwrap it
        if let captureDevice = captureDevice {
            
            do {
                let input = try AVCaptureDeviceInput(device: captureDevice)
                
                captureSession.addInput(input)
                
                let captureMetadataOutput = AVCaptureMetadataOutput()
                captureSession.addOutput(captureMetadataOutput)
                
                captureMetadataOutput.setMetadataObjectsDelegate(self, queue: .main)
                captureMetadataOutput.metadataObjectTypes = [.code128, .qr, .ean13,  .ean8, .code39] //AVMetadataObject.ObjectType
                
                captureSession.startRunning()
                
                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                videoPreviewLayer?.videoGravity = .resizeAspectFill
                videoPreviewLayer?.frame = cameraView.layer.bounds
                cameraView.layer.addSublayer(videoPreviewLayer!)
            } catch {
                print("Error Device Input")
            }
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        captureSession.stopRunning()
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count == 0 {
            print("No Input Detected")
            return
        }
        
        let metadataObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        guard let stringCodeValue = metadataObject.stringValue else { return }
//        if stringCodeValue == currentQr { return }
        currentQr = stringCodeValue
        onScanSuccess()
        // Create some label and assign returned string value to it
        print(stringCodeValue)
        // Perform further logic needed (ex. redirect to other ViewController)
        
    }
    
    @IBAction func onSendDataClick(_ sender: Any) {
        sendQrData()
    }
    
    private func sendQrData() {
        showProgress()
        HistoryCarAPI.sendQrCodeData(self, code: currentQr, lat: "100", lon: "100")
    }
    
    func onSendQrCodeDataSuccess(response: QrCode) {
        hideProgress()
        showAlertDialog(title: response.title ?? "", message: response.message ?? "")
        resetScanner()
    }
    
    func onSendQrCodeDataFail(response: QrCode) {
        hideProgress()
        showAlertDialog(title: response.title ?? "", message: response.message ?? "")
        resetScanner()
    }
    
    func onSendQrCodeDataError() {
        hideProgress()
        showDefaultErrorDialog()
        resetScanner()
    }
    
    private func onScanSuccess() {
        noScanLabel.isHidden = true
        scanSuccessLabel.isHidden = false
        sendDataButton.isEnabled = true
        captureSession.stopRunning()
    }
    
    private func resetScanner() {
        noScanLabel.isHidden = false
        scanSuccessLabel.isHidden = true
        sendDataButton.isEnabled = false
        captureSession.startRunning()
    }
}
