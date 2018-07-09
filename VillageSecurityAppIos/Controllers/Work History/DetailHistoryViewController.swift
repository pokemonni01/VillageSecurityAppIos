//
//  DetailHistoryViewController.swift
//  VillageSecurityAppIos
//
//  Created by Wachirapong on 29/5/2561 BE.
//  Copyright © 2561 Wachirapong. All rights reserved.
//

import UIKit
import GoogleMaps

class DetailHistoryViewController: BaseViewController, HistoryGuardDelegate {

    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var timeShowLabel: UILabel!
    
    var listGuardHistory: ListGuardHistory?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "ดูประวัติการทำงานรายคน"
        nameLabel.text = "นาย \(listGuardHistory?.mGuard?.first_name ?? "") \(listGuardHistory?.mGuard?.last_name ?? "")"
        companyLabel.text = listGuardHistory?.mGuard?.company?.name ?? ""
        timeShowLabel.text = listGuardHistory?.timeShow ?? ""
        setGoogleMap()
        loadListHistory()
    }
    
    private func loadListHistory() {
        showProgress()
        guard let pk = listGuardHistory?.pk else {
            showDefaultErrorDialog()
            return
        }
        ListHistoryGuardAPI.requestHistoryGuard(self, historyId: pk)
    }
    
    private func setGoogleMap() {
        self.mapView.settings.zoomGestures = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func moveCamera(listHistory: [ListHistory]) {
        var totalLat = 0.0
        var totalLon = 0.0
        for history in listHistory {
            totalLat += (Double(history.point?.lat ?? "0") ?? 0.0)
            totalLon += (Double(history.point?.lon ?? "0") ?? 0.0)
        }
        let avgLat = Double(totalLat/Double(listHistory.count))
        let avgLon = Double(totalLon/Double(listHistory.count))
        let camera = GMSCameraPosition.camera(withLatitude: avgLat,
                                              longitude: avgLon,
                                              zoom: 18)
        self.mapView.camera = camera
    }
    
    private func setPinOnMap(listHistory: [ListHistory]) {
        for history in listHistory {
            guard let point = history.point else {
                continue
            }
            let position = CLLocationCoordinate2D(latitude: Double(point.lat ?? "0") ?? 0.0, longitude: Double(point.lon ?? "0") ?? 0.0)
            let marker = GMSMarker(position: position)
            if (history.statusCheckout ?? "" == "YES") {
                marker.icon = UIImage(named: "Green Dot")
            } else {
                marker.icon = UIImage(named: "Red Dot")
            }
            marker.map = mapView
        }
    }
    
    private func setMapCamera(lat: Double, lon: Double) {
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lat, zoom: 6.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
    }
    
    func onRequestHistoryGuardSuccess(response: HistoryGuardResponse) {
        hideProgress()
        guard let listHistory = response.listHistory else {
            return
        }
        moveCamera(listHistory: listHistory)
        setPinOnMap(listHistory: listHistory)
    }
    
    func onRequestHistoryGuardFail(response: HistoryGuardResponse) {
        hideProgress()
        showAlertDialog(title: response.title ?? "", message: response.message ?? "")
    }
    
    func onRequestHistoryGuardError() {
        hideProgress()
        showDefaultErrorDialog()
    }

}
