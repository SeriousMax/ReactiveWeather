//
//  Double+RoundToPlaces.swift
//  ReactiveWeather
//
//  Created by Max Shnitov on 3/1/18.
//  Copyright © 2018 MAX-DEV. All rights reserved.
//

import Foundation

extension Double {
    
    /// Rounds the double to decimal places value
    ///
    /// - Parameter places: a number of simbols after comma
    /// - Returns: rounded double
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
}
