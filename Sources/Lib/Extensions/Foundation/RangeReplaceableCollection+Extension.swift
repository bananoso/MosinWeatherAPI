//
//  RangeReplaceableCollection+Extension.swift
//  Square
//
//  Created by Student on 31.10.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

extension RangeReplaceableCollection {
    
    public mutating func safeRemoveFirst() -> Element? {
        return unless(self.isEmpty) { self.removeFirst() }
    }
}
