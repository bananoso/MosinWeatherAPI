//
//  CountryData.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 10.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

class CountryData: ObservableObject<CountryData.Event> {

    public enum Event {
        case onSetWeather(Weather?)
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
    
    private let wrappedWeather: Wrapper<Weather?>
    private let wrappedCountry: Wrapper<Country>
    
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
        self.routeNotify(from: self.wrappedWeather, notify: Event.onSetWeather)
        self.routeNotify(from: self.wrappedCountry, notify: Event.onSetCountry)
    }
}


