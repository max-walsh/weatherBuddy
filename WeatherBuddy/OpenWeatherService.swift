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
    
    var baseURL:String = "http://api.openweathermap.org/data/2.5/"
    var apiKey:String = "93d98c361bc0d24cb301adc549eea5c4"
    var cityWeather = City()
    var cityForecast = Forecast()
    // http://api.openweathermap.org/data/2.5/forecast?q=London,us&APPID=93d98c361bc0d24cb301adc549eea5c4
    
    func cityWeatherByZipcode(cities: City, callback: (City)->Void) {

        //print("call back zipcode: \(cities.zipcode)")
        //let zip = "46556"
        //let test = self.cities.zipcode
        //let coordURL = "\(baseURL)zip=\(zip),us&APPID=\(apiKey)"
        let coordURL = "\(baseURL)weather?zip=\(cities.zipcode),us&APPID=\(apiKey)"

        let searchURL = NSURL(string: coordURL)
        let request = NSMutableURLRequest(URL: searchURL!)
        sleep(1)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) {
        (data, responseText, error) -> Void in
            if error != nil {
                print(error)
            } else {
                let result = String(data: data!, encoding: NSASCIIStringEncoding)!
                if (data == nil) {
                    print("data is nil")
                }
                // http://stackoverflow.com/questions/24056205/how-to-use-background-thread-in-swift
                //`let qualityOfServiceClass = QOS_CLASS_BACKGROUND
                //let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
                print("in apicall")
                self.resultJSON = result
                self.cityWeather = self.parseJSONZipcodeResponse(data!, city: cities)
                
                dispatch_async(dispatch_get_main_queue(), {
                //dispatch_async(backgroundQueue, {
                    
                    //callback(cities)
                    callback(self.cityWeather)
                    /*
                    dispatch_async(dispatch_get_main_queue(), { ()->Void in
                        print("What")
                        
                    })
                    */
                })
            }
        }
        task.resume()
    }
    
    func cityWeatherForecast(city: City, callback: (Forecast)->Void) {
        let coordURL = "\(baseURL)forecast?id=\(city.id),&APPID=\(apiKey)"
        let searchURL = NSURL(string: coordURL)
        let request = NSMutableURLRequest(URL: searchURL!)
        //sleep(1)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            if error != nil {
                print(error)
            } else {
                let result = String(data: data!, encoding:NSASCIIStringEncoding)!
                if (data == nil) {
                    print("something went wrong in cityWeatherForecast")
                }
                //self.resultJSON = result
                //// add forcast to each city not done called in CityDetailViewController
                self.cityForecast = self.parseJSONForecastResponse(data!)
                dispatch_async(dispatch_get_main_queue(), {
                    callback(self.cityForecast)
                })
            }
        }
        task.resume()
    }
    
    
    var resultJSON : String = "" {
        didSet {
            print("setting output as \(resultJSON)")
            print("\n")
        }
    }
    
    func parseJSONZipcodeResponse(data: NSData, city: City) -> City {
        let json = JSON(data: data)
        if (settings.units == .Fahrenheit) {
            city.currentTemp = KtoF(json["main"]["temp"].doubleValue)
        }
        else if (settings.units == .Celsius) {
            city.currentTemp = KtoC(json["main"]["temp"].doubleValue)
        }
        else {
            city.currentTemp = round(json["main"]["temp"].doubleValue)
        }

        city.maxTemp = KtoF(json["main"]["temp_max"].doubleValue)
        city.minTemp = KtoF(json["main"]["temp_min"].doubleValue)
        city.humidity = json["main"]["humidity"].intValue
        city.description = json["weather"][0]["main"].stringValue // more general
        city.detail = json["weather"][0]["description"].stringValue // more specific
        city.windSpeed = json["wind"]["speed"].doubleValue
        let degree = json["wind"]["deg"].doubleValue
        city.rain = json["clouds"]["all"].stringValue
        /*

        //city.id = json["id"].intValue
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        */
        city.sunrise1970 = json["sys"]["sunrise"].doubleValue
        city.sunset1970 = json["sys"]["sunset"].doubleValue
        /*
        let srise = NSDate(timeIntervalSince1970: json["sys"]["sunrise"].doubleValue)
        city.sunrise_date = json["sys"]["sunrise"].intValue
        city.sunrise = dateFormatter.stringFromDate(srise)
        city.sunrise = city.sunrise.stringByAppendingString(" AM")
        let sset = NSDate(timeIntervalSince1970: json["sys"]["sunset"].doubleValue)
        city.sunset_date = json["sys"]["sunset"].intValue
        city.sunset = dateFormatter.stringFromDate(sset)
        city.sunset = city.sunset.stringByAppendingString(" PM")
        */
        city.barometricPressure = json["main"]["pressure"].doubleValue
        let long = json["coord"]["lon"].doubleValue
        let lat = json["coord"]["lat"].doubleValue
        city.coordinates = CLLocation(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(long))
        city.id = json["id"].stringValue
        print("\(city.id)\n\n\n\n\n\n\n\n\n\n")
        
        // settting icon image and background image
        if (city.description == "Clear") {
            city.icon = UIImage(named: "Sun")!
            city.backgroundImage_c = UIImage(named: "Clear_big")!
            city.backgroundImage_nd = UIImage(named: "nd_Clear")!
        }
        else if (city.description == "Clouds") {
            city.icon = UIImage(named: "Cloud")!
            city.backgroundImage_c = UIImage(named: "Cloud_big")!
            city.backgroundImage_nd = UIImage(named: "nd_Cloud")!
        }
        else if (city.description == "Drizzle") {
            city.icon = UIImage(named: "Drizzle")!
            city.backgroundImage_c = UIImage(named: "Rain_big")!
            city.backgroundImage_nd = UIImage(named: "nd_Rain")!
        }
        else if (city.description == "Rain") {
            city.icon = UIImage(named: "Rain")!
            city.backgroundImage_c = UIImage(named: "Rain_big")!
            city.backgroundImage_nd = UIImage(named: "nd_Rain")!
        }
        else if (city.description == "Thunderstorm") {
            city.icon = UIImage(named: "Storm")!
            city.backgroundImage_c = UIImage(named: "Storm_big")!
            city.backgroundImage_nd = UIImage(named: "nd_Storm")!
        }
        else if (city.description == "Snow") {
            city.icon = UIImage(named: "Snow")!
            city.backgroundImage_c = UIImage(named: "Snow_big")!
            city.backgroundImage_nd = UIImage(named: "nd_Snow")!
        }
        else if (city.description == "Mist" || city.description == "Haze" ) {
            city.icon = UIImage(named: "FogDay")!
            city.backgroundImage_c = UIImage(named: "Clear_big")!
            city.backgroundImage_nd = UIImage(named: "nd_Fog")!
        }
        else {
            print("Description: \(city.description)")
            city.backgroundImage_c = UIImage(named: "Clear_big")!
            city.icon = UIImage(named: "Sun")!
            city.backgroundImage_nd = UIImage(named: "nd_Clear")!
        }

        if (degree >= 337.5 || degree < 22.5) {
            city.windDirection = "N"
        }
        else if (degree >= 22.5 && degree < 67.5) {
            city.windDirection = "NE"
        }
        else if (degree >= 67.5 && degree < 112.5) {
            city.windDirection = "E"
        }
        else if (degree >= 112.5 && degree < 157.5) {
            city.windDirection = "SE"
        }
        else if (degree >= 157.5 && degree < 202.5) {
            city.windDirection = "S"
        }
        else if (degree >= 202.5 && degree < 247.5) {
            city.windDirection = "SW"
        }
        else if (degree >= 247.5 && degree < 292.5) {
            city.windDirection = "W"
        }
        else if (degree >= 292.5 && degree < 337.5) {
            city.windDirection = "NW"
        }
        else {
            city.windDirection = "N"
        }
        
        city.updateSun(city.coordinates)

        
        return city
        
    }
    
    func parseJSONForecastResponse(data: NSData) -> Forecast {
        let json = JSON(data: data)
        let forecast = Forecast()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        var currentDate = dateFormatter.stringFromDate(NSDate())
        
        print("currentDate: \(currentDate)")
        // http://stackoverflow.com/questions/28365939/how-to-loop-through-json-with-swiftyjson
        //for (key, day) in json["list"] {
        for (_, day) in json["list"] {
            let date = day["dt_txt"].stringValue
            let dateComp = date.componentsSeparatedByString(" ")
            if (dateComp[0] != currentDate) {
                let min = day["main"]["temp_min"].doubleValue
                let max = day["main"]["temp_max"].doubleValue
                let desc = day["weather"]["main"].stringValue
//<<<<<<< HEAD
                var icon = UIImage(named: "Sun")
                if (desc == "Rain" ) {
                    icon = UIImage(named: "Rain")
                }
                else if (desc == "Snow" ) {
                    icon = UIImage(named: "Snow")
                }
                else if (desc == "Clouds" ) {
                    icon = UIImage(named: "Cloud")
                }
                else if (desc == "Mist" || desc == "Haze" ) {
                    icon = UIImage(named: "FogDay")
                }
                else if (desc == "Thunderstorm" ) {
                    icon = UIImage(named: "Storm")
                }
                else if (desc == "Drizzle" ) {
                    icon = UIImage(named: "Drizzle")
                }
                print("not Today: \(dateComp[0])")
                currentDate = dateComp[0]
                forecast.addDay(ForecastDay(minTemp: min, maxTemp: max, desc: desc, icon: icon!))
/*
=======
                print("not Today: \(dateComp[0])")
                currentDate = dateComp[0]
                forecast.addDay(ForecastDay(minTemp: min, maxTemp: max, desc: desc))
>>>>>>> persistence
*/
            } else {
                print("today")
            }
        }
        
        return forecast
    }
    
    func KtoF(K_Temp: Double) -> Double {
        return round(((K_Temp - 273.15)*1.8000) + 32.00)
    }
    func KtoC(K_Temp: Double) -> Double {
        return round(K_Temp - 273.15)
    }
}