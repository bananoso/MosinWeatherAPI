//
//  Countries.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 10.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

class Countries {
    
    public private(set) var values: [Country]
    
    public init(_ values: [Country] = []) {
        self.values = values
    }
}
