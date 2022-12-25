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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let centerCoordinateDict = UserDefaults.standard.dictionary(forKey: "centerCoordinate"){
            mapView.region.center.latitude = centerCoordinateDict["lati"] as! CLLocationDegrees
            mapView.region.center.longitude = centerCoordinateDict["long"] as! CLLocationDegrees
            print("CenterCoordinate is assigned in viewWillAppear")
        }
        if let span = UserDefaults.standard.dictionary(forKey: "span"){
            mapView.region.span.latitudeDelta = span["latiDelta"] as! CLLocationDegrees
            mapView.region.span.longitudeDelta = span["longDelta"] as! CLLocationDegrees
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //if let cameraBoundary = UserDefaults.standard.getCameraBoundary(){
        //    mapView.cameraBoundary = cameraBoundary
        //    print("cameraBoundary is assigned in viewWillAppear")
        //}
        if let centerCoordinateDict = UserDefaults.standard.dictionary(forKey: "centerCoordinate"){
            mapView.region.center.latitude = centerCoordinateDict["lati"] as! CLLocationDegrees
            mapView.region.center.longitude = centerCoordinateDict["long"] as! CLLocationDegrees
            print("CenterCoordinate is assigned in viewWillAppear")
        }
        if let span = UserDefaults.standard.dictionary(forKey: "span"){
            mapView.region.span.latitudeDelta = span["latiDelta"] as! CLLocationDegrees
            mapView.region.span.longitudeDelta = span["longDelta"] as! CLLocationDegrees
        }
        
        print("map view appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        var centerCoordinateDict: [String: Double] = ["lati":mapView.region.center.latitude,"long":mapView.region.center.longitude]
        print("center done")
        var spanDict: [String: Double] = ["latiDelta":mapView.region.span.latitudeDelta, "longDelta":mapView.region.span.longitudeDelta]
        print("span done")
        UserDefaults.standard.set(centerCoordinateDict, forKey: "centerCoordinate")
        UserDefaults.standard.set(spanDict, forKey: "span")

        print("map view disappear")

    }


}

