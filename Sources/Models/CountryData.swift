//
//  CountryData.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 10.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

class CountryData {

    public var weather: Weather?
    public let country: Country
    
    init(country: Country, weather: Weather?) {
        self.country = country
        self.weather = weather
    }
    
    convenience init(country: Country) {
        self.init(country: country, weather: nil)
    }
}


