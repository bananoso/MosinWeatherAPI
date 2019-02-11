//
//  Lens.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 08.02.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

struct Lens<A, B> {
    
    public var `for`: (A, B) -> A {
        return flip § to
    }
    
    public let from: (A) -> B
    public let to: (B, A) -> A
}
