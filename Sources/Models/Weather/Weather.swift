//
//  Weather.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 14.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

public struct Weather: Modelable {
    
    // MARK: -
    // MARK: Properties
    
    public var celsiusDescription: String? {
        return self.temperature.map { "\($0) \(UnitTemperature.celsius.symbol)" }
    }
    
    public let id: ID
    public let temperature: Int?
    public let updateDate: Date?
}
