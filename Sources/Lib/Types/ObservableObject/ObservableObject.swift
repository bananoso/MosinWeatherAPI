//
//  ObservableObject.swift
//  Square
//
//  Created by Student on 14.12.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

class ObservableObject<Property> {
    
    public typealias Handler = (Property) -> ()
    
    private let observers = Observers()
    
    @discardableResult
    public func observer(_ handler: @escaping Handler) -> Observer {
        let observer = Observer(sender: self, handler: handler)
        self.observers.add(observer)
        
        return observer
    }
    
    public func notify(_ property: Property) {
        self.observers.notify(property: property)
    }
    
    public func routeNotify<Observable: ObservableObject<Value>, Value>(
        from observable: Observable,
        notify: @escaping (Value) -> Property
    ) {
        observable.observer {
            self.notify(notify($0))
        }
    }
    
    public func routeNotify<Observable: ObservableObject<Property>>(from observable: Observable) {
        self.routeNotify(from: observable) { $0 }
    }
}
