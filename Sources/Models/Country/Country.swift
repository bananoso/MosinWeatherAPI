//
//  Country.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 10.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

public class Country: ObservableObject<Country.Event>, Modelable {

    // MARK: -
    // MARK: Subtypes

    public enum Event {
        case didChangeWeather(Country)
    }

    // MARK: -
    // MARK: Properties

    public let id: ID
    public var name: String
    public var capital: String

    public var weather: Weather? {
        didSet {
            self.notify(.didChangeWeather(self))
        }
    }

    // MARK: -
    // MARK: Init and Deinit

    init(id: ID, name: String, capital: String, weather: Weather? = nil) {
        self.id = id
        self.name = name
        self.capital = capital
        self.weather = weather
    }
}
