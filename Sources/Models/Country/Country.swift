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
    
    init(name: String, capital: String) {
        self.name = name
        self.capital = capital
    }
    
    convenience init(data: CountryJSON) {
        self.init(name: data.name, capital: data.capital)
    }
}
