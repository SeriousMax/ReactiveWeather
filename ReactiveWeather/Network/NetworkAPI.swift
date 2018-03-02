//
//  NetworkAPI.swift
//  ReactiveWeather
//
//  Created by Max Shnitov on 2/28/18.
//  Copyright © 2018 MAX-DEV. All rights reserved.
//
// This enum describes all API requests

import Foundation
import Moya

enum NetworkAPI: TargetType {
    case getWeather(city: String, units: String)
    
    var baseURL: URL {
        return URL(string: "\(Env.baseUrl())/data/2.5")!
    }
    
    var path: String {
        switch self {
        case .getWeather:
            return "weather"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getWeather:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Moya.Task {
        switch self {
        case .getWeather(let city, let units):
            let params = ["q" : city, "units" : units, "appid" : Env.apiKey()]
            return .requestCompositeData(bodyData: Data(), urlParameters: params)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type" : "application/json"]
    }
}
