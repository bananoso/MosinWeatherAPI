//
//  NSLocking+Extension.swift
//  Square
//
//  Created by Student on 25.10.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

extension NSLocking {
    
    public func locked<Result>(_ action: () -> Result) -> Result {
        self.lock()
        defer { self.unlock() }
        
        return action()
    }
}
