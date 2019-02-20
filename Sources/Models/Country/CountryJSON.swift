//
//  CountryJSON.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 29.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

public struct CountryJSON: Decodable {
    
    public let name: String
    public let capital: String
}
