//
//  WeatherView.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 10.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import UIKit

public class WeatherView: UIView {

    // MARK: -
    // MARK: Properties
    
    @IBOutlet public var capitalLabel: UILabel?
    @IBOutlet public var temperatureLabel: UILabel?
    
    // MARK: -
    // MARK: Public
    
    public func fill(with country: Country?) {
        self.capitalLabel?.text = country?.capital
        self.fill(with: country?.weather)
    }
    
    public func fill(with weather: Weather?) {
        self.temperatureLabel?.text = weather?.celsiusDescription
    }
}
