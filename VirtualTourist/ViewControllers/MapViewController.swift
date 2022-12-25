//
//  ViewController.swift
//  VirtualTourist
//
//  Created by Yuan Gao on 12/21/22.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
 
    @IBOutlet weak var mapView: MKMapView!
    var region:MKCoordinateRegion = MKCoordinateRegion()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        restoreMapViewState()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        restoreMapViewState()
        print("map view appear")
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        saveMapViewState()

        print("map view disappear")

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

    fileprivate func saveMapViewState() {
        var centerCoordinateDict: [String: Double] = ["lati":mapView.region.center.latitude,"long":mapView.region.center.longitude]
        print("center done")
        var spanDict: [String: Double] = ["latiDelta":mapView.region.span.latitudeDelta, "longDelta":mapView.region.span.longitudeDelta]
        print("span done")
        UserDefaults.standard.set(centerCoordinateDict, forKey: "centerCoordinate")
        UserDefaults.standard.set(spanDict, forKey: "span")
    }

}

