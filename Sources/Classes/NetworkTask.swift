//
//  NetworkTask.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 07.02.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

class NetworkTask: Cancellable {
    
    static var failed: NetworkTask {
        let task = NetworkTask(.init())
        task.state = .failed
        
        return task
    }
    
    public enum State {
        case idle
        case inLoad
        case didLoad
        case cancelled
        case failed
    }
    
    public let task: URLSessionTask
    
    public var isCancelled: Bool {
        return self.state == .cancelled
    }
    
    private var state = State.idle
    
    init(_ task: URLSessionTask) {
        self.task = task
    }
    
    func cancel() {
        self.task.cancel()
        self.state = .cancelled
    }
}
