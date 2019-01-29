//
//  CountryManager.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 29.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

class CountryManager {
    
    private let query = "https://restcountries.eu/rest/v2/all"
    
    public func loadCountries(_ execute: @escaping ([Country]) -> ()) {
        RequestService<[CountryJSON]>().loadData(query: self.query) {
            let countries = $0
                .filter { !$0.capital.isEmpty }
                .map(Country.init)
            
            execute(countries)
        }
    }
}
