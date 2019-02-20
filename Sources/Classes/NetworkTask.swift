//
//  NetworkTask.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 07.02.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

public class NetworkTask: Cancellable {
    
    // MARK: -
    // MARK: Subtypes
    
    public enum State {
        case idle
        case inLoad
        case didLoad
        case cancelled
        case failed
    }
    
    // MARK: -
    // MARK: Static
    
    static var failed: NetworkTask {
        let task = NetworkTask(.init())
        task.state = .failed
        
        return task
    }
    
    // MARK: -
    // MARK: Properties
    
    public var isCancelled: Bool {
        return self.state == .cancelled
    }
    
    public let task: URLSessionTask
    
    private var state = State.idle
    
    // MARK: -
    // MARK: Init and Deinit
    
    init(_ task: URLSessionTask) {
        self.task = task
    }
    
    // MARK: -
    // MARK: Public
    
    public func cancel() {
        self.task.cancel()
        self.state = .cancelled
    }
}
