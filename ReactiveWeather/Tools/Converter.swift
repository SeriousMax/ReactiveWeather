//
//  Converter.swift
//  ReactiveWeather
//
//  Created by Max Shnitov on 3/1/18.
//  Copyright © 2018 MAX-DEV. All rights reserved.
//

import Foundation

class Converter {
    
    /// Converts temperature from Celsius to Farenheit
    ///
    /// - Parameter temp: temperature in Farenheit
    class func celsiusToFarenheit(temp: inout Double) {
        temp = ((temp * 9) / 5) + 32
    }

    /// Converts temperature from Farenheit to Celsius
    ///
    /// - Parameter temp: temperature in Celsius
    class func farenheitToCelsius(temp: inout Double) {
        temp = ((temp - 32) * 5) / 9
    }
    
}
