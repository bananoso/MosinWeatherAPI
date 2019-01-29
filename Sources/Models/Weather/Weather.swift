//
//  Weather.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 14.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

fileprivate struct DimensionSymbol {
    static let celsius = "℃"
}

class Weather {
    
    public var celsiusString: String {
        return "\(self.temperature) \(DimensionSymbol.celsius)"
    }
    
    public var temperature: Int
    public var updateDate: Date
    
    init(temperature: Int, updateDate: Date) {
        self.temperature = temperature
        self.updateDate = updateDate
    }
    
    convenience init(data: WeatherJSON) {
        let temperature = data.main.temp.int ?? 0
        let date = Date(timeIntervalSince1970: data.dt)
        
        self.init(temperature: temperature, updateDate: date)
    }
}
