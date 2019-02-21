//
//  CountryRealmDataBaseService.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 21.02.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

public class CountryRealmDataBaseService: RealmDataBaseService<RLMCountry> {
    
    // MARK: -
    // MARK: Open
    
    open override func writeStorage(_ rlmStorage: RLMCountry, storage: Country) {
        rlmStorage.name = storage.name
        rlmStorage.capital = storage.capital

        let rlmWeather = rlmStorage.weather
        let weather = storage.weather
        
        if rlmWeather == nil {
            rlmStorage.weather = weather.map(RLMWeather.init)
        } else {
            rlmWeather?.temperature.value = weather?.temperature
            rlmWeather?.updateDate = weather?.updateDate
        }
    }
}
