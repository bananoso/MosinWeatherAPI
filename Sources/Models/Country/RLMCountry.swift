//
//  RLMCountry.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 21.02.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

public class RLMCountry: RLMModel, ModelConvertable {
    
    // MARK: -
    // MARK: Properties
    
    @objc dynamic public var name = ""
    @objc dynamic public var capital = ""
    @objc dynamic public var weather: RLMWeather?
    
    public var model: Country? {
        return self.parsedID().map {
            Country(id: $0, name: self.name, capital: self.capital)
        }
    }
    
    // MARK: -
    // MARK: Init and Deinit
    
    required public convenience init(model: Country) {
        self.init()
        
        self.name = model.name
        self.capital = model.capital
        self.weather = model.weather.map(RLMWeather.init)
    }
}
