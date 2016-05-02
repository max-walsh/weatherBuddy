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
            cities[index].currentTemp_F = city.currentTemp_F
            cities[index].currentTemp_C = city.currentTemp_C
            cities[index].currentTemp_K = city.currentTemp_K
            cities[index].description = city.description
            cities[index].humidity = city.humidity
            cities[index].maxTemp_F = city.maxTemp_F
            cities[index].minTemp_F = city.minTemp_F
            cities[index].maxTemp_K = city.maxTemp_K
            cities[index].minTemp_K = city.minTemp_K
            cities[index].maxTemp_C = city.maxTemp_C
            cities[index].minTemp_C = city.minTemp_C
            cities[index].name = city.name
            cities[index].clouds = city.clouds
            cities[index].state = city.state
            cities[index].sunrise = city.sunrise
            cities[index].sunset = city.sunset
            cities[index].windDirection = city.windDirection
            cities[index].windSpeed = city.windSpeed
            cities[index].zipcode = city.zipcode
            index += 1
        }
    }
    
    func rearrangeCities(fromIndex: Int, toIndex: Int) {
        
        let cityToMove = cities[fromIndex]
        cities.removeAtIndex(fromIndex)
        cities.insert(cityToMove, atIndex: toIndex)
    }
    
    func printCities() {
        for city in cities {
            if city.name != "" {
                print("\(city.name): \(city.zipcode)")
            }
        }
        print("")
    }

}