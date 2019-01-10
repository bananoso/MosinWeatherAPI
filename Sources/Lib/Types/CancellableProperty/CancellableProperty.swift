//
//  CancellableProperty.swift
//  Square
//
//  Created by Mosin Dmitry on 24.12.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

class CancellableProperty: AbstractCancellableProperty<Cancellable?> {
    
    public init() {
        super.init(initial: nil) { $0?.cancel() }
    }
}
