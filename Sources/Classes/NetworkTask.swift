//
//  NetworkTask.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 07.02.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

class NetworkTask: Cancellable {
    
    public let task: URLSessionTask
    
    public private(set) var isCancelled = false
    
    init(_ task: URLSessionTask) {
        self.task = task
    }
    
    func cancel() {
        self.task.cancel()
        self.isCancelled = true
    }
}
