//
//  WeatherJSON.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 29.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

struct WeatherJSON: Decodable {
    
    // MARK: -
    // MARK: Subtypes
    
    struct MainData: Decodable {
        let temp: Double
    }
    
    // MARK: -
    // MARK: Properties
    
    let main: MainData
    let dt: TimeInterval
}
