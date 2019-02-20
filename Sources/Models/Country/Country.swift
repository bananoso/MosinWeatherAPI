//
//  Country.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 10.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

public protocol CountryStorage: class {
    
    var name: String { get set }
    var capital: String { get set }
}

public class RLMCountry: RLMModel, CountryStorage {
    
    // MARK: -
    // MARK: Properties
    
    @objc dynamic public var name = ""
    @objc dynamic public var capital = ""
}

public class Country: ObservableObject<Country.Event> {

    // MARK: -
    // MARK: Subtypes

    public enum Event {
        case didChangeWeather(Country)
    }

    // MARK: -
    // MARK: Properties

    public var id: ID
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

//public protocol CountryType: CountryStorage, Modelable { }


//public class Country<Persistence: Persistable>: Model<Persistence>, CountryType where Persistence.Storage: CountryStorage {
//
//    // MARK: -
//    // MARK: Properties
//
//    public var name = "" {
//        didSet { self.write() }
//    }
//
//    public var capital = "" {
//        didSet { self.write() }
//    }
//
//    // MARK: -
//    // MARK: Open
//
//    open override func readStorage(_ storage: StorageType) {
//        let persistence = self.persistence
//
//        persistence.read(storage.name, to: &self.name)
//        persistence.read(storage.capital, to: &self.capital)
//    }
//
//    open override func writeStorage(_ storage: StorageType) {
//        storage.name = self.name
//        storage.capital = self.capital
//    }
//}
