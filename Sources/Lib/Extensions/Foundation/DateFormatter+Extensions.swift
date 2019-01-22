//
//  DateFormatter+Extensions.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 21.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    convenience init(dateStyle: Style, timeStyle: Style) {
        self.init()
        
        self.dateStyle = dateStyle
        self.timeStyle = timeStyle
    }
}
