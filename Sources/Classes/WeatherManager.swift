//
//  WeatherManager.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 29.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

class WeatherManager {
    
    public func loadWeather(city: String, execute: @escaping (Weather) -> ()) {
        RequestService<WeatherJSON>().loadData(query: self.query(city: city)) {
            let weather = Weather(data: $0)
            execute(weather)
        }
    }
    
    private func query(city: String) -> String {
        return "https://api.openweathermap.org/data/2.5/weather?q="
            + city
            + "&units=metric&appid=5372fc075a669c8e7a76effda37c5eb5"
    }
}
