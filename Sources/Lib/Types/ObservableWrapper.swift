//
//  Wrapper.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 29.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

class ObservableWrapper<Value>: ObservableObject<Value> {
    
    private(set) var value: Value
    
    init(_ value: Value) {
        self.value = value
    }
    
    public func update<Result>(_ action: (inout Value) -> Result) -> Result {
        defer { self.notify(self.value) }
        
        return action(&self.value)
    }
}
