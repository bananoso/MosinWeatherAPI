//
//  CountriesData.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 29.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

class CountriesData: ObservableObject<CountryData.Event> {
    
    public var count: Int {
        return self.values.count
    }
    
    private var values: [CountryData]
    
    init(values: [CountryData] = []) {
        self.values = values
        
        super.init()
        self.subscribe()
    }
    
    convenience init(countries: [Country]) {
        let countriesData = countries.map(CountryData.init)
        self.init(values: countriesData)
    }
    
    public subscript(index: Int) -> CountryData {
        get { return self.values[index] }
        set { self.values[index] = newValue }
    }
    
    private func subscribe() {
        self.values.forEach(self.routeNotify)
    }
}
