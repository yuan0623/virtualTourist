//
//  ViewController.swift
//  VirtualTourist
//
//  Created by Yuan Gao on 12/21/22.
//

import UIKit
import MapKit

import CoreData

class MapViewController: UIViewController, MKMapViewDelegate, NSFetchedResultsControllerDelegate {


class MapViewController: UIViewController {

    
 
    @IBOutlet weak var mapView: MKMapView!
    var region:MKCoordinateRegion = MKCoordinateRegion()
    var pins: [Pin] = []
    var dataController:DataController!
    var annotations = [MKPointAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        let longTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(longTap))
        mapView.addGestureRecognizer(longTapGesture)
        // Do any additional setup after loading the view.

        restoreMapViewState()
        
        let fetchRequest:NSFetchRequest<Pin> = Pin.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        if let result = try? dataController.viewContext.fetch(fetchRequest){
            pins = result
            for pin in pins {
                let coordinate = CLLocationCoordinate2D(latitude: pin.latitude, longitude: pin.longitude)
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotations.append(annotation)
            }
            

        if let centerCoordinateDict = UserDefaults.standard.dictionary(forKey: "centerCoordinate"){
            mapView.region.center.latitude = centerCoordinateDict["lati"] as! CLLocationDegrees
            mapView.region.center.longitude = centerCoordinateDict["long"] as! CLLocationDegrees
            print("CenterCoordinate is assigned in viewWillAppear")
        }
        if let span = UserDefaults.standard.dictionary(forKey: "span"){
            mapView.region.span.latitudeDelta = span["latiDelta"] as! CLLocationDegrees
            mapView.region.span.longitudeDelta = span["longDelta"] as! CLLocationDegrees

        }
        self.mapView.addAnnotations(annotations)
        
    }
    

    @objc func longTap(sender: UIGestureRecognizer){
        print("long tap")
        if sender.state == .began {
            let locationInView = sender.location(in: mapView)
            let locationOnMap = mapView.convert(locationInView, toCoordinateFrom: mapView)
            addAnnotation(location: locationOnMap)

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
    }

    func addAnnotation(location: CLLocationCoordinate2D){
        
        let pin = Pin(context: dataController.viewContext)
        pin.creationDate = Date()
        pin.longitude = location.longitude
        pin.latitude = location.latitude
        try? dataController.viewContext.save()
        
        let annotation = MKPointAnnotation()
        annotation.coordinate.latitude = pin.latitude
        annotation.coordinate.longitude = pin.longitude
        self.mapView.addAnnotation(annotation)
            //annotation.title = "Some Title"
            //annotation.subtitle = "Some Subtitle"
            //self.mapView.addAnnotation(annotation)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        restoreMapViewState()
        print("map view appear")
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        saveMapViewState()

        var centerCoordinateDict: [String: Double] = ["lati":mapView.region.center.latitude,"long":mapView.region.center.longitude]
        print("center done")
        var spanDict: [String: Double] = ["latiDelta":mapView.region.span.latitudeDelta, "longDelta":mapView.region.span.longitudeDelta]
        print("span done")
        UserDefaults.standard.set(centerCoordinateDict, forKey: "centerCoordinate")
        UserDefaults.standard.set(spanDict, forKey: "span")


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

extension MapViewController{

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

func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
    print("tapped on pin ")
}

func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    if control == view.rightCalloutAccessoryView {
        if let doSomething = view.annotation?.title! {
            print("do something")
            performSegue(withIdentifier: "showPhotoView", sender: nil)
        }
    }
  }
}

