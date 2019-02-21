//
//  RLMWeather.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 21.02.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

import RealmSwift

public class RLMWeather: RLMModel, ModelConvertable {
    
    // MARK: -
    // MARK: Properties
    
    @objc dynamic public var updateDate: Date?
    
    public let temperature = RealmOptional<Int>()
    
    public var model: Weather? {
        return self.parsedID().map {
            Weather(
                id: $0,
                temperature: self.temperature.value,
                updateDate: self.updateDate
            )
        }
    }
    
    // MARK: -
    // MARK: Init and Deinit
    
    required public convenience init(model: Weather) {
        self.init()
        
        self.id = "\(model.id)_rlmweather"
        self.temperature.value = model.temperature
        self.updateDate = model.updateDate
    }
}
