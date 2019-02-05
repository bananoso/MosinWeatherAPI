//
//  Countries.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 29.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

class Countries: ObservableObject<Countries.Event> {
    
    public enum Event {
        case didAppend([Country])
        case didRemove(Country)
        case didUpdate(Country)
    }
    
    public var count: Int {
        return self.values.count
    }
    
    private var values: [Country]
    
    init(values: [Country] = []) {
        self.values = values
    }
    
    public subscript(index: Int) -> Wrapper<Country> {
        let wrapped = Wrapper(self.values[index])
        wrapped.observer {
            self.notify(.didUpdate($0))
        }
        
        return wrapped
    }

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
}
