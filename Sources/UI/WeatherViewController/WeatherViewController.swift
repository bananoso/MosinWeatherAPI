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
    
    public var networkManager: NetworkManager?
    public var country: Wrapper<Country>?
    
    private let observer = CancellableProperty()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadWeatherData()
    }
    
    private func loadWeatherData() {
        guard let country = self.country else { return }
        self.observer.value = country.observer {
            $0.weather.do { weather in
                dispatchOnMain {
                    self.rootView?.fill(with: weather)
                }
            }
        }
        
        self.networkManager?.loadWeather(country: country)
    }
}
