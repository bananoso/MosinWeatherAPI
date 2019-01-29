//
//  WeatherJSON.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 29.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

struct MainData: Decodable {
    
    public let temp: Double
}

struct WeatherJSON: Decodable {
    
    let main: MainData
    let dt: TimeInterval
}
