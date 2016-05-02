//
//  MapViewController.swift
//  WeatherBuddy
//
//  Created by Max Walsh on 4/6/16.
//  Copyright © 2016 Katie Kuenster. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var i:Int = 0
    var j:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func mapView(mapview: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        // http://stackoverflow.com/questions/24467408/swift-add-mkannotationview-to-mkmapview
        //print("viewForAnnotation")
        if (annotation is MKUserLocation) {
            //if annotation is not an MKPointAnnotation (eg. MKUserLocation),
            //return nil so map draws default view for it (eg. blue dot)...
            return nil
        }
        
        let reuseId = "test"
        annotation.title
        var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            anView!.image = cities.cityByName(annotation.title!!).icon
            anView!.canShowCallout = true
        }
        else {
            //we are re-using a view, update its annotation reference...
            anView!.annotation = annotation
        }
        j += 1
        return anView
   
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        i = 0
        j = 0
        while i < cities.cityCount() {
            let city = cities.cityAtIndex(i)
            let tempPin = MKPointAnnotation()
            tempPin.coordinate = city.coordinates.coordinate
            tempPin.title = city.name
            self.mapView.addAnnotation(tempPin)
            let annotationTestView = MKAnnotationView()
            annotationTestView.annotation = tempPin
            annotationTestView.canShowCallout = true
            annotationTestView.enabled = true
            
            i += 1
   
        }
        i = 0
        j = 0
    }

}
