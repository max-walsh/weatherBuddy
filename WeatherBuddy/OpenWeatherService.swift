//
//  OpenWeatherService.swift
//  WeatherBuddy
//
//  Created by Max Walsh on 4/3/16.
//  Copyright © 2016 Katie Kuenster. All rights reserved.
//

// http://stackoverflow.com/questions/28365939/how-to-loop-through-json-with-swiftyjson
// http://stackoverflow.com/questions/24056205/how-to-use-background-thread-in-swift
// http://api.openweathermap.org/data/2.5/forecast?q=London,us&APPID=93d98c361bc0d24cb301adc549eea5c4

import Foundation
import CoreLocation
import SwiftyJSON

class OpenWeatherService {
    
    var baseURL: String = "http://api.openweathermap.org/data/2.5/"
    var apiKey: String = "93d98c361bc0d24cb301adc549eea5c4"
    var cityWeather = City()
    var cityForecast = Forecast()
    
    func cityWeatherByZipcode(cities: City, callback: (City)->Void) {

        let coordURL = "\(baseURL)weather?zip=\(cities.zipcode),us&APPID=\(apiKey)"
        let searchURL = NSURL(string: coordURL)
        let request = NSMutableURLRequest(URL: searchURL!)
        sleep(1)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) {
        (data, responseText, error) -> Void in
            if (error != nil) {
                print("error: \(error)")
            } else {
                _ = String(data: data!, encoding: NSASCIIStringEncoding)!
                if (data == nil) {
                    print("data is nil")
                }
                
                self.cityWeather = self.parseJSONZipcodeResponse(data!, city: cities)
                //self.resultJSON = result
                dispatch_async(dispatch_get_main_queue(), {
                    callback(self.cityWeather)
                })
            }
        }
        task.resume()
    }
    
    func cityWeatherForecast(city: City, callback: (Forecast)->Void) {

        let coordURL = "\(baseURL)forecast?id=\(city.id),&APPID=\(apiKey)"
        let searchURL = NSURL(string: coordURL)
        let request = NSMutableURLRequest(URL: searchURL!)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                _ = String(data: data!, encoding:NSASCIIStringEncoding)!
                if (data == nil) {
                    print("something went wrong in cityWeatherForecast")
                }
                self.cityForecast = self.parseJSONForecastResponse(data!, timeZoneOffset: city.timeZoneOffset)
                //self.resultJSON = result
                dispatch_async(dispatch_get_main_queue(), {
                    callback(self.cityForecast)
                })
            }
        }
        task.resume()
    }
    
    
    var resultJSON : String = "" {
        didSet {
            print("JSON result: \(resultJSON)")
            print("\n")
        }
    }
    
    func parseJSONZipcodeResponse(data: NSData, city: City) -> City {
        
        let json = JSON(data: data)

        city.currentTemp_F = KtoF(json["main"]["temp"].doubleValue)
        city.currentTemp_C = KtoC(json["main"]["temp"].doubleValue)
        city.currentTemp_K = round(json["main"]["temp"].doubleValue)
        city.maxTemp_F = KtoF(json["main"]["temp_max"].doubleValue)
        city.minTemp_F = KtoF(json["main"]["temp_min"].doubleValue)
        city.maxTemp_C = KtoC(json["main"]["temp_max"].doubleValue)
        city.minTemp_C = KtoC(json["main"]["temp_min"].doubleValue)
        city.maxTemp_K = round(json["main"]["temp_max"].doubleValue)
        city.minTemp_K = round(json["main"]["temp_min"].doubleValue)
        
        city.humidity = json["main"]["humidity"].intValue
        city.description = json["weather"][0]["main"].stringValue // more general
        city.detail = json["weather"][0]["description"].stringValue // more specific
        city.windSpeed = round((json["wind"]["speed"].doubleValue) * 2.23694 * 10) / 10
        city.windDirection = degreeToDirection(json["wind"]["deg"].doubleValue)
        city.clouds = json["clouds"]["all"].stringValue
        city.sunrise1970 = json["sys"]["sunrise"].doubleValue
        city.sunset1970 = json["sys"]["sunset"].doubleValue
        city.barometricPressure = round((json["main"]["pressure"].doubleValue)*100*100*0.00014503773773022)/100
        
        let long = json["coord"]["lon"].doubleValue
        let lat = json["coord"]["lat"].doubleValue
        city.coordinates = CLLocation(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(long))
        city.id = json["id"].stringValue
        
        // settting icon image and background image
        if (city.description == "Clear") {
            city.icon = UIImage(named: "Sun")!
            city.backgroundImage_c = UIImage(named: "Clear_big")!
            city.backgroundImage_nd = UIImage(named: "nd_Clear")!
            city.backgroundImage_dog = UIImage(named: "Clear_dog")!
        } else if (city.description == "Clouds") {
            city.icon = UIImage(named: "Cloud")!
            city.backgroundImage_c = UIImage(named: "Cloud_big")!
            city.backgroundImage_nd = UIImage(named: "nd_Cloud")!
            city.backgroundImage_dog = UIImage(named: "Cloud_dog")!
        } else if (city.description == "Drizzle") {
            city.icon = UIImage(named: "Drizzle")!
            city.backgroundImage_c = UIImage(named: "Rain_big")!
            city.backgroundImage_nd = UIImage(named: "nd_Rain")!
            city.backgroundImage_dog = UIImage(named: "Rain_dog")!
        } else if (city.description == "Rain") {
            city.icon = UIImage(named: "Rain")!
            city.backgroundImage_c = UIImage(named: "Rain_big")!
            city.backgroundImage_nd = UIImage(named: "nd_Rain")!
            city.backgroundImage_dog = UIImage(named: "Rain_dog")!
        } else if (city.description == "Thunderstorm") {
            city.icon = UIImage(named: "Storm")!
            city.backgroundImage_c = UIImage(named: "Storm_big")!
            city.backgroundImage_nd = UIImage(named: "nd_Storm")!
            city.backgroundImage_dog = UIImage(named: "Storm_dog")!
        } else if (city.description == "Snow") {
            city.icon = UIImage(named: "Snow")!
            city.backgroundImage_c = UIImage(named: "Snow_big")!
            city.backgroundImage_nd = UIImage(named: "nd_Snow")!
            city.backgroundImage_dog = UIImage(named: "Snow_dog")!
        } else if (city.description == "Mist" || city.description == "Haze" ) {
            city.icon = UIImage(named: "FogDay")!
            city.backgroundImage_c = UIImage(named: "Fog_big")!
            city.backgroundImage_nd = UIImage(named: "nd_Fog")!
            city.backgroundImage_dog = UIImage(named: "Fog_dog")!
        } else {
            print("Description: \(city.description)")
            city.backgroundImage_c = UIImage(named: "Clear_big")!
            city.icon = UIImage(named: "Sun")!
            city.backgroundImage_nd = UIImage(named: "nd_Clear")!
            city.backgroundImage_dog = UIImage(named: "Clear_dog")!
        }

        city.updateSunriseSunsetData(city.coordinates)

        return city
    }
    
    func parseJSONForecastResponse(data: NSData, timeZoneOffset: Double) -> Forecast {
        
        let json = JSON(data: data)
        let forecast = Forecast()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDateSeconds = NSDate().timeIntervalSince1970 + timeZoneOffset
        _ = dateFormatter.stringFromDate(NSDate(timeIntervalSince1970: NSTimeInterval(currentDateSeconds)))
        
        var currentDate = ""
        var min_K = 0.0
        var max_K = 0.0
        var min_F = 0.0
        var max_F = 0.0
        var min_C = 0.0
        var max_C = 0.0
        
        for (_, day) in json["list"] {
            let date = day["dt_txt"].stringValue
            let dateComp = date.componentsSeparatedByString(" ")
            var desc = ""
            var icon = UIImage(named: "Sun")
            if (dateComp[0] != currentDate) {
                currentDate = dateComp[0]
                min_K = round(day["main"]["temp_min"].doubleValue)
                max_K = round(day["main"]["temp_max"].doubleValue)
                min_C = KtoC(day["main"]["temp_min"].doubleValue)
                max_C = KtoC(day["main"]["temp_max"].doubleValue)
                min_F = KtoF(day["main"]["temp_min"].doubleValue)
                max_F = KtoF(day["main"]["temp_max"].doubleValue)

                currentDate = dateComp[0]
            } else {
                var posMin = round(day["main"]["temp_min"].doubleValue)
                var posMax = round(day["main"]["temp_max"].doubleValue)
                if (posMin < min_K) {
                    min_K = posMin
                }
                if (posMax > max_K) {
                    max_K = posMax
                }
                
                posMin = KtoC(day["main"]["temp_min"].doubleValue)
                posMax = KtoC(day["main"]["temp_max"].doubleValue)
                if (posMin < min_C) {
                    min_C = posMin
                }
                if (posMax > max_C) {
                    max_C = posMax
                }
                
                posMin = KtoF(day["main"]["temp_min"].doubleValue)
                posMax = KtoF(day["main"]["temp_max"].doubleValue)
                if (posMin < min_F) {
                    min_F = posMin
                }
                if (posMax > max_F) {
                    max_F = posMax
                }
            }
            desc = day["weather"][0]["main"].stringValue
            if (desc == "Rain" ) {
                icon = UIImage(named: "Rain")
            } else if (desc == "Snow" ) {
                icon = UIImage(named: "Snow")
            } else if (desc == "Clouds" ) {
                icon = UIImage(named: "Cloud")
            } else if (desc == "Mist" || desc == "Haze" ) {
                icon = UIImage(named: "FogDay")
            } else if (desc == "Thunderstorm" ) {
                icon = UIImage(named: "Storm")
            } else if (desc == "Drizzle" ) {
                icon = UIImage(named: "Drizzle")
            }
            if (dateComp[1] == "21:00:00") {
                forecast.addDay(ForecastDay(minTemp_F: min_F, maxTemp_F: max_F,
                    minTemp_C: min_C, maxTemp_C: max_C,
                    minTemp_K: min_K, maxTemp_K: max_K, desc: desc, icon: icon!))
            }
        }
        return forecast
    }
    
    // functions for converting units
    func KtoF(K_Temp: Double) -> Double {
        return round(((K_Temp - 273.15)*1.8000) + 32.00)
    }
    
    func KtoC(K_Temp: Double) -> Double {
        return round(K_Temp - 273.15)
    }
    
    func degreeToDirection(degree: Double) -> String {
        if (degree >= 337.5 || degree < 22.5) {
            return "N"
        } else if (degree >= 22.5 && degree < 67.5) {
            return "NE"
        } else if (degree >= 67.5 && degree < 112.5) {
            return "E"
        } else if (degree >= 112.5 && degree < 157.5) {
            return "SE"
        } else if (degree >= 157.5 && degree < 202.5) {
            return "S"
        } else if (degree >= 202.5 && degree < 247.5) {
            return "SW"
        } else if (degree >= 247.5 && degree < 292.5) {
            return "W"
        } else if (degree >= 292.5 && degree < 337.5) {
            return "NW"
        } else {
            return "N"
        }

    }
    
    
}