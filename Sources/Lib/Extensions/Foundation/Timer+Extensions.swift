//
//  Timer+Extensions.swift
//  Square
//
//  Created by Student on 14.11.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

extension Timer {
    
    public static func scheduledWeakTimer(
        interval: TimeInterval,
        repeats: Bool,
        handler: @escaping () -> ()
    )
        -> Timer
    {
        let weakHandler = TimerWeakHandler(handler: handler)
        
        return self.scheduledTimer(
            timeInterval: interval,
            target: weakHandler,
            selector: #selector(weakHandler.execute),
            userInfo: nil,
            repeats: repeats
        )
    }
}

fileprivate class TimerWeakHandler {
    
    private var handler: () -> ()
    
    public init(handler: @escaping () -> ()) {
        self.handler = handler
    }
    
    @objc func execute() {
        self.handler()
    }
}
