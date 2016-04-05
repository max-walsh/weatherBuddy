//
//  OpenWeatherService.swift
//  WeatherBuddy
//
//  Created by Max Walsh on 4/3/16.
//  Copyright © 2016 Katie Kuenster. All rights reserved.
//

import Foundation
import CoreLocation
import SwiftyJSON

class OpenWeatherService {
    
    var baseURL:String = "http://api.openweathermap.org/data/2.5/weather?"
    var apiKey:String = "93d98c361bc0d24cb301adc549eea5c4"
    var cities = [City]()
    
    /*
    init() {
        url = ""
        apiKey = ""
    }
    */
    
    func citiesWeatherByCoordinates(callback: ([City])->Void) {
        //let i:Int = 0
        
        //let coordURL = "\(baseURL)lat=\(cities[i].coordinates.coordinate.latitude)&lon=\(cities[i].coordinates.coordinate.longitude)&APPID=\(apiKey)"
        
        let lat:CLLocationDegrees = 41.7056
        let long:CLLocationDegrees = 86.2353
        let coordURL = "\(baseURL)lat=\(lat)&lon=\(long)&APPID=\(apiKey)"
        
        let searchURL = NSURL(string: coordURL)
        let request = NSMutableURLRequest(URL: searchURL!)
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) {
            (data, responseText, error) -> Void in
            if error != nil {
                print(error)
            } else {
                let result = String(data: data!, encoding: NSASCIIStringEncoding)!
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.resultJSON = result
                    self.parseJSONCoordResponse(data!)
                    callback(self.cities)
                })
            }
        }
        task.resume()
    }
    
    var resultJSON : String = "" {
        didSet {
            print("setting output as \(resultJSON)")
        }
    }
    
    func parseJSONCoordResponse(data: NSData) -> Void {
        //let json = JSON(data: data)
        
    }
}