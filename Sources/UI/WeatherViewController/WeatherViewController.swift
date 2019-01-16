//
//  WeatherViewController.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 10.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import UIKit

fileprivate struct Constant {
    
    static let celsius = "℃"
    static let loading = "Loading"
    
    static let query: (String) -> String = {
        return "https://api.openweathermap.org/data/2.5/weather?q="
            + $0
            + "&units=metric&appid=5372fc075a669c8e7a76effda37c5eb5"
    }
}

class WeatherViewController: UIViewController, RootViewRepresentable {

    typealias RootView = WeatherView
    
    public var city = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.prepareTextLabels()
        self.prepareWeatherInfo()
    }
    
    private func prepareTextLabels() {
        self.rootView?.cityLabel?.text = self.city
        self.rootView?.temperatureLabel?.text = Constant.loading
    }
    
    private func prepareWeatherInfo() {
        URL(query: Constant.query(self.city)).do {
            NetworkManager<Weather>().loadData(url: $0, completion: self.handleWeather)
        }
    }
    
    private func handleWeather(_ weather: Weather?) {
        weather.do { data in
            DispatchQueue.main.async {
                self.rootView?.temperatureLabel?.text = data.main.temp.description + Constant.celsius
            }
        }
    }
}
