//
//  Weather.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 14.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

struct Weather: Decodable {
    
    struct MainData: Decodable {
        public let temp: Double
    }
    
    public let main: MainData
}
