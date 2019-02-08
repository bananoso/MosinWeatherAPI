//
//  Weak.swift
//  Square
//
//  Created by Student on 17.12.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

public struct Weak<Wrapped: AnyObject> {
    
    private(set) weak var value: Wrapped?
    
    public init(_ value: Wrapped) {
        self.value = value
    }
    
    public func strongify<Result>(_ transform: (Wrapped) -> Result?) -> Result? {
        return self.value.flatMap(transform)
    }
}
