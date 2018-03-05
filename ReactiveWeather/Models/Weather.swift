//
//  Weather.swift
//  ReactiveWeather
//
//  Created by Max Shnitov on 2/28/18.
//  Copyright © 2018 MAX-DEV. All rights reserved.
//

import Foundation

/// Now the model is implements Codable protocol,
/// so it can be encoded to JSON and send to server
class Weather: Codable {
    var name: String?
    var main: Main?
    var weather: [WeatherDetails]?
}

class WeatherDetails: Codable {
    var description: String?
    var main: String?
    var icon: String?
}

class Main: Codable {
    var temp: Double?
    var pressure: Double?
    var humidity: Double?
}
