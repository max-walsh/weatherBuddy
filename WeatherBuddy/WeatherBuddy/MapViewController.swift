//
//  MapViewController.swift
//  WeatherBuddy
//
//  Created by Max Walsh on 4/6/16.
//  Copyright © 2016 Katie Kuenster. All rights reserved.
//

// http://stackoverflow.com/questions/24467408/swift-add-mkannotationview-to-mkmapview

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var i = 0
    var j = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Prevents user interaction with the map, except for tapping icon and seeing city name
        self.mapView.zoomEnabled = false
        self.mapView.rotateEnabled = false
        self.mapView.scrollEnabled = false
        self.mapView.pitchEnabled = false
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func mapView(mapview: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        if (annotation is MKUserLocation) {
            // if there is no annotation, return nil so map draws default view
            return nil
        }
        
        let reuseId = "cityIcon"
        annotation.title
        var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
        if (anView == nil) {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            anView!.image = cities.cityByName(annotation.title!!).icon
            anView!.canShowCallout = true
        }
        else {
            // update annotation reference if we are reusing a view
            anView!.annotation = annotation
        }
        j += 1
        return anView
   
    }
    
    override func viewWillAppear(animated: Bool) {
        
        i = 0
        j = 0
        while (i < cities.cityCount()) {
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
