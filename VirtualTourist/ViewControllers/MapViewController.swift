//
//  ViewController.swift
//  VirtualTourist
//
//  Created by Yuan Gao on 12/21/22.
//

import UIKit
import MapKit
extension UserDefaults{
    func setCenterCoordinate(centerCoordinate:CLLocationCoordinate2D?,forKey key:String){
        var centerCoordinateData: NSData?
        if let centerCoordinate = centerCoordinate{
            do {
                centerCoordinateData = try NSKeyedArchiver.archivedData(withRootObject: centerCoordinate, requiringSecureCoding: false) as NSData?
                set(centerCoordinateData,forKey: key)
                print("centerCoordinateData saved")
            }
            catch let erro{
                print("error archiving CLLocationCoordinate2D data",erro)
            }
        }
    }
    func setCameraZoomRange(cameraZoomRange:MKMapView.CameraZoomRange?,forKey key:String){
        var cameraZoomRangeData: NSData?
        if let cameraZoomRange = cameraZoomRange{
            do {
                cameraZoomRangeData = try NSKeyedArchiver.archivedData(withRootObject: cameraZoomRange, requiringSecureCoding: false) as NSData?
                set(cameraZoomRangeData,forKey: key)
                print("cameraZoomRangeData saved")
            }
            catch _{
                print("error archiving MKMapView.CameraZoomRange data")
            }
        }
    }
    func getCameraZoomRange()-> MKMapView.CameraZoomRange?{
        var cameraZoomRange: MKMapView.CameraZoomRange?
        if let cameraZoomRangeData = data(forKey: "cameraZoomRange"){
            do{
                cameraZoomRange = try NSKeyedUnarchiver.unarchivedObject(ofClass: MKMapView.CameraZoomRange.self, from: cameraZoomRangeData)
            }
            catch let error{
                print("error unarchiving cameraZoomRange data", error)
            }
        }
        return cameraZoomRange
    }
}
class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let cameraZoomRange = UserDefaults.standard.getCameraZoomRange(){
            mapView.cameraZoomRange = cameraZoomRange
            print("cameraZoomRange is assigned in viewDidLoad")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let cameraZoomRange = UserDefaults.standard.getCameraZoomRange(){
            mapView.cameraZoomRange = cameraZoomRange
            print("cameraZoomRange is assigned in viewWillAppear")
        }
        
        print("map view appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //var CenterCoordinateDict: [String: Double] = ["lati":mapView.centerCoordinate.latitude,"long":mapView.centerCoordinate.longitude]
        //UserDefaults.standard.set(CenterCoordinateDict, forKey: "centerCoordinate")
        //UserDefaults.standard.setCenterCoordinate(centerCoordinate: mapView.centerCoordinate,forKey:"centerCoordinate")
        UserDefaults.standard.setCameraZoomRange(cameraZoomRange: mapView.cameraZoomRange, forKey: "cameraZoomRange")
        //UserDefaults.standard.set(mapView.cameraZoomRange,forKey:"zoomRange")
        print("map view disappear")

    }


}

