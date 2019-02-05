//
//  Country.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 10.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

class Country {
    
    public let name: String
    public let capital: String
    public var weather: Weather?
    
    init(name: String, capital: String, weather: Weather? = nil) {
        self.name = name
        self.capital = capital
        self.weather = weather
    }
}
