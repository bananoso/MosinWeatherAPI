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
    
    func fill(with country: Country?) {
        self.capitalLabel?.text = country?.capital
        self.fill(with: country?.weather)
    }
    
    func fill(with weather: Weather?) {
        self.temperatureLabel?.text = weather?.celsiusDescription
    }
}
