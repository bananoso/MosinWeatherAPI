//
//  Wrapper.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 29.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

class Wrapper<Value>: ObservableObject<Value> {
    
    public var value: Value {
        didSet {
            self.notify(self.value)
        }
    }
    
    init(_ value: Value) {
        self.value = value
    }
    
    public func update<Result>(_ action: (Value) -> Result) -> Result {
        defer {
            self.notify(self.value)
        }
        
        return action(self.value)
    }
}
