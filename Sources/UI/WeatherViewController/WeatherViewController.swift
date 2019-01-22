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
    
    static let query: (String) -> String = {
        return "https://api.openweathermap.org/data/2.5/weather?q="
            + $0
            + "&units=metric&appid=5372fc075a669c8e7a76effda37c5eb5"
    }
}

class WeatherViewController: UIViewController, RootViewRepresentable {

    typealias RootView = WeatherView
    typealias WeatherDataHandler = F.Completion<Weather?>
    
    private var capitalTitle: String {
        return self.countryData?.country.capital ?? Strings.loadingError
    }
    
    public var onDownloadedWeatherHandler: WeatherDataHandler?
    public var countryData: CountryData?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.countryData.apply(self.rootView?.fill)
        self.loadWeatherData()
    }
    
    private func loadWeatherData() {
        NetworkManager<Weather>().loadData(query: Strings.query(self.capitalTitle)) {
            self.onDownloadedWeatherHandler?($0)
            $0.do { data in
                DispatchQueue.main.async {
                    self.rootView?.fill(with: data)
                }
            }
        }
    }
}
