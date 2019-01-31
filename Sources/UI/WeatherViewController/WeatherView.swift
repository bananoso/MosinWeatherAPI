//
//  WeatherView.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 10.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import UIKit

class WeatherView: UIView {

    @IBOutlet var capitalLabel: UILabel?
    @IBOutlet var temperatureLabel: UILabel?
    
    func fill(with countryData: CountryData) {
        self.capitalLabel?.text = countryData.country.capital
        countryData.weather.do(self.fill)
    }
    
    func fill(with weather: Weather) {
        self.temperatureLabel?.text = weather.celsiusDescription
    }
}
