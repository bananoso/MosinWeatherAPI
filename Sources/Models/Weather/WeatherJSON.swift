//
//  WeatherJSON.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 29.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

struct WeatherJSON: Decodable {
    
    struct MainData: Decodable {
        let temp: Double
    }
    
    let main: MainData
    let dt: TimeInterval
}
