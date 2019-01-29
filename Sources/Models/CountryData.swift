//
//  CountryData.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 10.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

class CountryData: ObservableObject<CountryData.Event> {

    enum Event {
        case onSetWeather(Weather)
        case onSetCountry(Country)
    }
    
    public var weather: Weather? {
        get { return self.wrappedWeather.value }
        set { self.wrappedWeather.value = newValue }
    }
    
    public var country: Country {
        get { return self.wrappedCountry.value }
        set { self.wrappedCountry.value = newValue }
    }
    
    private var wrappedWeather: Wrapper<Weather?>
    private var wrappedCountry: Wrapper<Country>
    
    init(country: Country, weather: Weather?) {
        self.wrappedCountry = Wrapper(country)
        self.wrappedWeather = Wrapper(weather)
        
        super.init()
        self.subscribe()
    }
    
    convenience init(country: Country) {
        self.init(country: country, weather: nil)
    }
    
    private func subscribe() {
        self.wrappedWeather.observer {
            $0.do { self.notify(.onSetWeather($0)) }
        }
        
        self.wrappedCountry.observer {
            self.notify(.onSetCountry($0))
        }
    }
}


