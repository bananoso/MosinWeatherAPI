//
//  ObservableObject.swift
//  Square
//
//  Created by Student on 14.12.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

public class ObservableObject<Property> {
    
    // MARK: -
    // MARK: Subtypes
    
    public typealias Handler = (Property) -> ()
    
    // MARK: -
    // MARK: Properties
    
    private let observers = Observers()
    
    // MARK: -
    // MARK: Public
    
    @discardableResult
    public func observer(_ handler: @escaping Handler) -> Observer {
        let observer = Observer(sender: self, handler: handler)
        self.observers.add(observer)
        
        return observer
    }
    
    public func notify(_ property: Property) {
        self.observers.notify(property: property)
    }
}
