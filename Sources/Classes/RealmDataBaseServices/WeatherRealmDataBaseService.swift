//
//  WeatherRealmDataBaseService.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 21.02.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

public class WeatherRealmDataBaseService: RealmDataBaseService<RLMWeather> {
    
    // MARK: -
    // MARK: Open
    
    open override func writeStorage(_ rlmStorage: RLMWeather, storage: Weather) {
        rlmStorage.temperature.value = storage.temperature
        rlmStorage.updateDate = storage.updateDate
    }
}
