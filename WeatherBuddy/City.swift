//
//  City.swift
//  WeatherBuddy
//
//  Created by Max Walsh on 3/30/16.
//  Copyright © 2016 Katie Kuenster. All rights reserved.
//

import Foundation
import CoreLocation
import SwiftyJSON


class City {
    var currentTemp:Double
    var humidity:Int
    var description:String
    var minTemp:Double
    var maxTemp:Double
    var windSpeed:Double
    var windDirection:Double
    var rain:String
    var sunrise:Int
    var sunset:Int
    var name:String
    var state:String
    var zipcode:String
    var country:String
    var barometricPressure:Int
    var coordinates:Coordinates
    var ows:OpenWeatherService
    var gms:GoogleMapsService
    
    init() {
        self.currentTemp = 0.0
        self.humidity = 0
        self.description = ""
        self.minTemp = 0.0
        self.maxTemp = 0.0
        self.windSpeed = 0.0
        self.windDirection = 0.0
        self.rain = ""
        self.sunrise = 0
        self.sunset = 0
        self.name = "Notre Dame"
        self.state = "IN"
        self.zipcode = "46556"
        self.country = "United States of America"
        self.barometricPressure = 0
        self.coordinates = Coordinates()
        self.ows = OpenWeatherService()
        self.gms = GoogleMapsService()
        
    }
    
    func setCurrentLocation() {
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        let currentLocation = locationManager.location
        let coord = currentLocation?.coordinate
        print(currentLocation)
        //let lat = coord?.latitude
        //let long = coord?.longitude
        let lat:CLLocationDegrees = 40.714224
        let long:CLLocationDegrees = -73.961452
        var location = CLLocation(latitude: lat, longitude: long)
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            if error != nil {
                print("Reverse Geocoder failed with error" + error!.localizedDescription)
                return
            }
            //if placemarks!.count > 0 {
            if  let pm = placemarks![0] as? CLPlacemark {
                print("setCurrentLocation: \(pm.locality!)")
                self.name = pm.locality!
            } else {
                print("problem with data from geocoder")
            }
        })
        
        
        self.coordinates.latitude = 40.714224
        self.coordinates.longitude = -73.961452
        /*
        gms.getCurrentCity {
            (self.name) in
                self = self
                self.tableview.reloadData() ///??? maybe dont need
        }
        */
        //let newCity = gms.getCurrentCity(self.coordinates)
        //self.name = newCity

        func getCurrentCity() {
            
        }
        
    }
    
}