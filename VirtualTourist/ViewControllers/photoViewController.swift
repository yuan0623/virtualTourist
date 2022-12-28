//
//  photoViewController.swift
//  VirtualTourist
//
//  Created by Yuan Gao on 12/27/22.
//

import UIKit
import MapKit
class photoViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    var region:MKCoordinateRegion = MKCoordinateRegion()
    var pinCoordinate:CLLocationCoordinate2D = CLLocationCoordinate2D()
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        restoreMapViewState()
        getSelectedPin()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        restoreMapViewState()
        getSelectedPin()
    }
    
    
    fileprivate func restoreMapViewState() {

        region.center = pinCoordinate
        if let span = UserDefaults.standard.dictionary(forKey: "span"){
            region.span.latitudeDelta = span["latiDelta"] as! CLLocationDegrees
            region.span.longitudeDelta = span["longDelta"] as! CLLocationDegrees
        }
        mapView.setRegion(region, animated: true)
    }
    
    fileprivate func getSelectedPin() {

        let annotation = MKPointAnnotation()
        annotation.coordinate = pinCoordinate
        self.mapView.addAnnotation(annotation)
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



extension photoViewController{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { print("no mkpointannotaions"); return nil }

        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView

        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        return pinView
    }
}
