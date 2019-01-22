//
//  Double+Extensions.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 17.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

extension Double {
    
    var int: Int? {
        if self > Double(Int.min) && self < Double(Int.max) {
            return Int(self)
        }
        
        return nil
    }
}
