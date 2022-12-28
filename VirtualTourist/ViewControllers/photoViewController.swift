//
//  photoViewController.swift
//  VirtualTourist
//
//  Created by Yuan Gao on 12/27/22.
//

import UIKit
import MapKit
class photoViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    var region:MKCoordinateRegion = MKCoordinateRegion()
    override func viewDidLoad() {
        super.viewDidLoad()
        restoreMapViewState()
        // Do any additional setup after loading the view.
    }
    
    
    fileprivate func restoreMapViewState() {
        if let centerCoordinateDict = UserDefaults.standard.dictionary(forKey: "centerCoordinate"){
            region.center.latitude = centerCoordinateDict["lati"] as! CLLocationDegrees
            region.center.longitude = centerCoordinateDict["long"] as! CLLocationDegrees
            print("CenterCoordinate is assigned in viewWillAppear")
        }
        if let span = UserDefaults.standard.dictionary(forKey: "span"){
            region.span.latitudeDelta = span["latiDelta"] as! CLLocationDegrees
            region.span.longitudeDelta = span["longDelta"] as! CLLocationDegrees
        }
        mapView.setRegion(region, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
