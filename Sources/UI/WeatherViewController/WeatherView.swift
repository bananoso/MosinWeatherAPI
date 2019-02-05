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
    
    func fill(with wrappedCountry: Wrapper<Country>) {
        let country = wrappedCountry.value
        self.capitalLabel?.text = country.capital
        country.weather.do(self.fill)
    }
    
    func fill(with weather: Weather) {
        self.temperatureLabel?.text = weather.celsiusDescription
    }
}
