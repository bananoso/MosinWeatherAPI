//
//  DispathTime+Extension.swift
//  Square
//
//  Created by Student on 25.10.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

extension DispatchTime {
    
    public static func after(interval: TimeInterval) -> DispatchTime {
        return .now() + interval
    }
}
