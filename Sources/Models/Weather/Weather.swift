//
//  Weather.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 14.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

import RealmSwift

public class RLMWeather: RLMModel {
    
    // MARK: -
    // MARK: Properties
    
    @objc dynamic public var updateDate: Date?
    
    public let temperature = RealmOptional<Int>()
}

public struct Weather {
    
    // MARK: -
    // MARK: Properties
    
    public var celsiusDescription: String {
        return "\(self.temperature) \(UnitTemperature.celsius.symbol)"
    }
    
    public let temperature: Int
    public let updateDate: Date
}
