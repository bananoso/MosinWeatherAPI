//
//  ObservableObject+Observer.swift
//  Square
//
//  Created by Student on 14.12.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

extension ObservableObject {
    
    public class Observer: Hashable, Cancellable {

        public var isObserving: Bool {
            return self.sender != nil
        }
        
        public var isCancelled: Bool {
            return !self.isObserving
        }
        
        public var hashValue: Int {
            return ObjectIdentifier(self).hashValue
        }
        
        weak private(set) var sender: AnyObject?
        public let handler: Handler
        
        public init(sender: AnyObject, handler: @escaping Handler) {
            self.sender = sender
            self.handler = handler
        }
        
        public func cancel() {
            self.sender = nil
        }
        
        public static func == (lhs: Observer, rhs: Observer) -> Bool {
            return lhs === rhs
        }
    }
}
