//
//  Countries.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 29.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

public class Countries: ObservableObject<Countries.Event> {
    
    // MARK: -
    // MARK: Subtypes
    
    public enum Event {
        case didAppend([Country])
        case didRemove(Country)
        case didUpdate(Country)
    }
    
    // MARK: -
    // MARK: Properties
    
    public var count: Int {
        return self.values.count
    }
    
    private var values: [Country]
    
    // MARK: -
    // MARK: Init and Deinit
    
    init(values: [Country] = []) {
        self.values = values
    }
    
    // MARK: -
    // MARK: Public
    
    public func append(countriesOf: [Country]) {
        self.values.append(contentsOf: countriesOf)
        self.notify(.didAppend(countriesOf))
    }
    
    public func append(_ newElement: Country) {
        self.append(countriesOf: [newElement])
    }
    
    public func remove(at index: Int) -> Country {
        let value = self.values.remove(at: index)
        defer { self.notify(.didRemove(value)) }
        
        return value
    }
    
    // MARK: -
    // MARK: Array protocol
    
    public subscript(index: Int) -> Country {
        // TODO: Cancel observer
        let country = self.values[index]
//        country.observer { _ in
//            self.notify(.didUpdate(country))
//        }
        
        return country
    }
}
