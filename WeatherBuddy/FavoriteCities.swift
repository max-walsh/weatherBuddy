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
            cities[index].currentTemp = city.currentTemp
            cities[index].maxTemp = city.maxTemp
            index++
        }
        //print(index)
        //print(cities.count)
        //cities[index] = city///hopefully works???
        
    }

}