//
//  Units.swift
//  ReactiveWeather
//
//  Created by Max Shnitov on 3/1/18.
//  Copyright © 2018 MAX-DEV. All rights reserved.
//

import Foundation

enum Units {
    case metric, imperial
    
    /// String to send to OpenWeatherMap API for units system selection
    var stringValue: String {
        switch self {
        case .metric:
            return "metric"
        case .imperial :
            return "imperial"
        }
    }
    
    /// Symbol to mark temperature value
    var tempMark: String {
        switch self {
        case .metric:
            return "C"
        case .imperial :
            return "F"
        }
    }
}

extension Units {
    
    // MARK: Init and Deinit
    
    /// Init units with segmented control selected index
    init?(index: Int) {
        switch index {
        case 0: self = .metric
        case 1: self = .imperial
        default: return nil
        }
    }
}
