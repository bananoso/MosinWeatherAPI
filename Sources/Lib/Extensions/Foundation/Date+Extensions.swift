//
//  Date+Extensions.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 21.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

extension Date {
    
    func formattedDate(style: DateFormatter.Style) -> String {
        return self.formatted(dateStyle: style, timeStyle: .none)
    }
    
    func formattedTime(style: DateFormatter.Style) -> String {
        return self.formatted(dateStyle: .none, timeStyle: style)
    }
    
    func formattedDataTime(style: DateFormatter.Style) -> String {
        return self.formatted(dateStyle: style, timeStyle: style)
    }
    
    func formatted(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> String {
        return DateFormatter(dateStyle: dateStyle, timeStyle: timeStyle).string(from: self)
    }
}
