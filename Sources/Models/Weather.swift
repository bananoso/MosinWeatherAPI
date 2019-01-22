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
        
        public var celsiusString: String {
            return self.temp.int
                .map{ $0.description + "℃" }
                ?? "Error"
        }
    }
    
    public let main: MainData
    public let dt: TimeInterval
    
    public var updateDate: Date {
        return Date(timeIntervalSince1970: self.dt)
    }
}
