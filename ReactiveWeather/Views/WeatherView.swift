//
//  WeatherView.swift
//  ReactiveWeather
//
//  Created by Max Shnitov on 2/28/18.
//  Copyright © 2018 MAX-DEV. All rights reserved.
//

import RxSwift
import RxCocoa

class WeatherView: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var cityNameLbl: UILabel!
    @IBOutlet weak var temperatureLbl: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var tempSelector: UISegmentedControl!
    
    @IBOutlet weak var testButton: UIButton!
    
    private let viewModel = WeatherViewModel()
    
    private let disposeBag = DisposeBag()
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Binding IBOutlets to the `viewModel` properties and adding those
        /// bindings to the `disposeBag` for automatic dispose on `deinit`
        
        disposeBag.insert(
            viewModel.cityName.asObservable()
            .bind(to: cityNameLbl.rx.text)
        )
        
        disposeBag.insert(
            viewModel.temperature.asObservable()
            .bind(to: temperatureLbl.rx.text)
        )
        
        disposeBag.insert(
            searchTextField.rx.text
            .orEmpty
            .debounce(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .bind(to: viewModel.searchText)
        )
        
        disposeBag.insert(
            viewModel.icon.asObservable()
            .bind(to: weatherIcon.rx.image)
        )
        
        disposeBag.insert(
            tempSelector.rx.selectedSegmentIndex
            .map{ Units(index: $0) }
            .bind(to: viewModel.units)
        )
        
        /// Test binding UIButton tap event to viewModel method
        disposeBag.insert(
            testButton.rx.tap
                .bind { self.viewModel.testRequest() }
        )
        
    }

}

