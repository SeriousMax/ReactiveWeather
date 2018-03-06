//
//  WeatherVM.swift
//  ReactiveWeather
//
//  Created by Max Shnitov on 2/28/18.
//  Copyright © 2018 MAX-DEV. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya
import Nuke

class WeatherViewModel {
    
    // MARK: Properties
    
    let cityName = BehaviorRelay(value: "")
    let temperature = BehaviorRelay(value: "")
    let searchText = BehaviorRelay(value: "")
    let icon = BehaviorRelay(value: UIImage())
    let units = BehaviorRelay(value: Units(index: 0))
    
    var weather: Weather? {
        
        /// This fires each time new weather did set
        didSet {
            if let name = weather?.name {
                DispatchQueue.main.async {
                    self.cityName.accept(name)
                }
            }
            if let temp = weather?.main?.temp, let units = units.value {
                DispatchQueue.main.async {
                    self.temperature.accept("\(temp.rounded(toPlaces: 1))°\(units.tempMark)")
                }
            }
            if let iconName = weather?.weather?[0].icon {
                let url = "\(Env.baseUrl())/img/w/\(iconName).png"
                Manager.shared.loadImage(with: URL(string: url)!, completion: {
                    if let image = $0.value {
                        DispatchQueue.main.async {
                            self.icon.accept(image)
                        }
                    }
                })
            }
        }
    }
    
    
    /// Init provider with network logger just to see what do we send and receive
    private let provider = MoyaProvider<NetworkAPI>(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    private let disposeBag = DisposeBag()
    
    // MARK: Init and Deinit
    
    init() {
        
        /// Binding `units` type to `temperature` string then adding this binding
        /// to `disposeBag` for automatic dispose this binding on `deinit`
        disposeBag.insert(
            units.asObservable().map {
                
                /// Each time user changes temperature unit this map will convert
                /// temperature value and build a new string with it
                self.convertTemperature(to: $0)
            }
            .bind(to: temperature)
        )
        
        /// Subscribing to weather updates
        disposeBag.insert(
            searchText.asObservable()
                .filter { !$0.isEmpty } /// Ignoring empty strings
                .map {

                    /// Each time user changes city name this map will
                    /// generate new weather request
                    self.getWeather(for: $0)
                }
                .switchLatest()
                
                /// Subscribe to weather changes: each time new weather data
                /// received it will set to `weather` property
                .subscribe { self.weather = $0.element }
        )
 
    }
    
    private func getWeather(for city: String) -> PrimitiveSequence<SingleTrait, Weather> {
        return provider.rx
            .request(.getWeather(city: city,
                                units: (self.units.value?.stringValue)!))
            .map(Weather.self)
    }
    
    private func convertTemperature(to units: Units?) -> String {
        if var temp = self.weather?.main?.temp, let units = units {
            units == .metric ?
                Converter.farenheitToCelsius(temp: &temp) :
                Converter.celsiusToFarenheit(temp: &temp)
            
            /// Update temperature value in current `weather` property
            self.weather?.main?.temp = temp
            
            /// Build new string with temperature value
            return "\(temp.rounded(toPlaces: 1))°\(units.tempMark)"
        }
        return ""
    }
    
    /// This is the test method just to check if our Codable model
    /// can be successfully encoded and send to the server
    func testRequest() {
        if let weather = self.weather {
            print("sending test request...")
            disposeBag.insert(
                provider.rx.request(.updateWeather(newWeather: weather))
                    .subscribe({ (event) in
                        print("test request done: \(event)")
                    })
            )
        }
    }

}
