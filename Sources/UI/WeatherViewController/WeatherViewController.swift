//
//  WeatherViewController.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 10.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import UIKit

fileprivate struct Strings {
    
    static let loadingError = "Loading error"
}

class WeatherViewController: UIViewController, RootViewRepresentable {

    typealias RootView = WeatherView
    
    private var capitalTitle: String {
        return self.countryData?.country.capital ?? Strings.loadingError
    }
    
    public var countryData: CountryData?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.countryData.apply(self.rootView?.fill)
        self.loadWeatherData()
    }
    
    private func loadWeatherData() {        
        WeatherManager().loadWeather(city: self.capitalTitle) { weather in
            self.countryData?.weather = weather
            
            dispatchOnMain {
                self.rootView?.fill(with: weather)
            }
        }
    }
}
