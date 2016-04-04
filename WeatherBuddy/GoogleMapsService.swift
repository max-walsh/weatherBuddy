//
//  GoogleMapsService.swift
//  WeatherBuddy
//
//  Created by Max Walsh on 4/3/16.
//  Copyright © 2016 Katie Kuenster. All rights reserved.
//

import Foundation
import SwiftyJSON

class GoogleMapsService {
    var url:String
    var apiKey:String
    var city:City?
    
    init() {
        //let HomeURL:String = "South Bend,IN" //// TEMP
        url = "https://maps.googleapis.com/maps/api/geocode/json?"//"https://maps.googleapis.com/maps/api/geocode/json?address=\(HomeURL)&key=AIzaSyDs1GjFH50vGnLv5yvjbCI-6bxOi-F1OFw"
        apiKey = "AIzaSyDs1GjFH50vGnLv5yvjbCI-6bxOi-F1OFw"
    }
    
    var resultJSON : String = "" {
        didSet {
            print("setting output as \(resultJSON)")
        }
    }
    
    func parseGetCityResponse(data: NSData) -> String {
        let json = JSON(data: data)
        let cityName = json["results"][0]["address_components"][3]["long_name"].stringValue
        print("City Name: \(cityName)")
        return cityName
    }
    
    func getCurrentCity(callback: (City)->Void) {
        var name = ""
        let lat = "40.714224"
        let long = "-73.961452"
        //let apiKey = "AIzaSyDs1GjFH50vGnLv5yvjbCI-6bxOi-F1OFw"
        let googleURL = url + "latlng=\(lat),\(long), <#T##Int32#>)&key=\(apiKey)"
        let URL = NSURL(string: googleURL)
        let request = NSMutableURLRequest(URL: URL!)
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) {
            (data, responseText, error) -> Void in
            if error != nil {
                print(error)
            } else {
                let result = String(data: data!, encoding: NSASCIIStringEncoding)!
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.resultJSON = result
                    self.parseGetCityResponse(data!)
                    callback(self.city!)
                })
            }
        }
        task.resume()
        //print("name: \(name)")
        //return name
    }
    
}