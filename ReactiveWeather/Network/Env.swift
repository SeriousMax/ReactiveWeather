//
//  Env.swift
//  ReactiveWeather
//
//  Created by Max Shnitov on 3/1/18.
//  Copyright © 2018 MAX-DEV. All rights reserved.
//
// This class helps to get application environment properties
// from custom user-defined build settings

import Foundation

class Env {

    /// Returns base server URL
    ///
    /// - Returns: base server URL string
    class func baseUrl() -> String {
        return Bundle.main.infoDictionary!["API_BASE_URL_ENDPOINT"] as! String
    }
    
    /// Returns application key for access OpenWeatherMap API
    ///
    /// - Returns: application key string
    class func apiKey() -> String {
        return Bundle.main.infoDictionary!["OPENWEATHER_API_KEY"] as! String
    }
    
}
