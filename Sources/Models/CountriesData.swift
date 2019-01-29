//
//  CountriesData.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 29.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

class CountriesData: ObservableObject<CountryData.Event> {
    
    let values: [CountryData]
    
    init(values: [CountryData] = []) {
        self.values = values
        
        super.init()
        self.subscribe()
    }
    
    convenience init(countries: [Country]) {
        let countriesData = countries.map(CountryData.init)
        self.init(values: countriesData)
    }
    
    private func subscribe() {
        self.values.forEach {
            $0.observer {
                self.notify($0)
            }
        }
    }
}
