//
//  FavoriteCities.swift
//  WeatherBuddy
//
//  Created by Katie Kuenster on 4/5/16.
//  Copyright © 2016 Katie Kuenster. All rights reserved.
//

import Foundation

class FavoriteCities: NSObject {
    
    private var cities:[City] = []
    
    func cityCount() -> Int {
        return cities.count
    }
    
    func cityAtIndex(index: Int) -> City {
        return cities[index]
    }
    
    func removeCityAtIndex(index: Int) -> Void {
        cities.removeAtIndex(index)
    }
    
    func cityByName(cityName: String) -> City {
        for city in cities {
            if city.name == cityName {
                return city
            }
        }
        return City()
    }
    
    func addCity(city: String, state: String, zip: String) {
        let newCity = City()
        newCity.name = city
        newCity.state = state
        newCity.zipcode = zip
        cities.append(newCity)
    }
    
    func changeWeather(updatedCities: [City]) {
        var index:Int = 0
        for city in updatedCities {
            cities[index].barometricPressure = city.barometricPressure
            cities[index].coordinates = city.coordinates
            cities[index].country = city.country
            cities[index].currentTemp = city.currentTemp
            cities[index].description = city.description
            cities[index].humidity = city.humidity
            cities[index].maxTemp = city.maxTemp
            cities[index].minTemp = city.minTemp
            cities[index].name = city.name
            cities[index].rain = city.rain
            cities[index].state = city.state
            cities[index].sunrise = city.sunrise
            cities[index].sunset = city.sunset
            cities[index].windDirection = city.windDirection
            cities[index].windSpeed = city.windSpeed
            cities[index].zipcode = city.zipcode
            
            print ("name: \(cities[index].name)     temp: \(cities[index].currentTemp)")
            index += 1
        }
        //print(index)
        //print(cities.count)
        //cities[index] = city///hopefully works???
        
    }
    
    

}