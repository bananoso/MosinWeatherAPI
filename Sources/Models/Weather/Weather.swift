//
//  Weather.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 14.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

class Weather {
    
    public var celsiusDescription: String {
        return "\(self.temperature) \(UnitTemperature.celsius.symbol)"
    }
    
    public let temperature: Int
    public let updateDate: Date
    
    init(temperature: Int, updateDate: Date) {
        self.temperature = temperature
        self.updateDate = updateDate
    }
}
