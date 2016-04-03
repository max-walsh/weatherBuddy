//
//  GoogleMapsService.swift
//  WeatherBuddy
//
//  Created by Max Walsh on 4/3/16.
//  Copyright © 2016 Katie Kuenster. All rights reserved.
//

import Foundation

class GoogleMapsService {
    var url:String
    var apiKey:String
    
    init() {
        //let HomeURL:String = "South Bend,IN" //// TEMP
        url = ""//"https://maps.googleapis.com/maps/api/geocode/json?address=\(HomeURL)&key=AIzaSyDs1GjFH50vGnLv5yvjbCI-6bxOi-F1OFw"
        apiKey = "AIzaSyDs1GjFH50vGnLv5yvjbCI-6bxOi-F1OFw"
    }
}