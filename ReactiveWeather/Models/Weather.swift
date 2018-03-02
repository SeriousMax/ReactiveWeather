//
//  Weather.swift
//  ReactiveWeather
//
//  Created by Max Shnitov on 2/28/18.
//  Copyright © 2018 MAX-DEV. All rights reserved.
//

import Foundation

class Weather: Decodable {
    var name: String?
    var main: Main?
    var weather: [WeatherDetails]?
}

class WeatherDetails: Decodable {
    var description: String?
    var main: String?
    var icon: String?
}

class Main: Decodable {
    var temp: Double?
    var pressure: Double?
    var humidity: Double?
}
