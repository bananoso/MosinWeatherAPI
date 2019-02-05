//
//  NetworkManager.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 29.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

class NetworkManager {
    
    private struct Strings {
        
        static let allCountriesQuery = "https://restcountries.eu/rest/v2/all"
        
        static func weatherQuery(city: String) -> String {
            return "https://api.openweathermap.org/data/2.5/weather?q="
                + city
                + "&units=metric&appid=5372fc075a669c8e7a76effda37c5eb5"
        }
    }
    
    private var countryRequestService: RequestService<[CountryJSON]>
    private var weatherRequestService: RequestService<WeatherJSON>
    
    init(countryRequestService: RequestService<[CountryJSON]>, weatherRequestService: RequestService<WeatherJSON>) {
        self.countryRequestService = countryRequestService
        self.weatherRequestService = weatherRequestService
    }
    
    public func loadCountries(_ completion: F.Completion<[Country]>? = nil) {
        self.load(
            query: Strings.allCountriesQuery,
            requestService: self.countryRequestService,
            parser: { modelJSON in
                modelJSON
                    .filter { !$0.capital.isEmpty }
                    .map { Country(name: $0.name, capital: $0.capital) }
            },
            completion: completion
        )
    }
    
    public func loadWeather(country: Wrapper<Country>, completion: F.Completion<Weather>? = nil) {
        self.load(
            query: Strings.weatherQuery(city: country.value.capital),
            requestService: self.weatherRequestService,
            parser: { data in
                return country.update {
                    let weather = Weather(
                        temperature: data.main.temp.int ?? 0,
                        updateDate: Date(timeIntervalSince1970: data.dt)
                    )
                    $0.weather = weather
                    
                    return weather
                }
            },
            completion: completion
        )
    }
    
    private func load<ModelJSON: Decodable, Model>(
        query: String,
        requestService: RequestService<ModelJSON>,
        parser: @escaping (ModelJSON) -> Model,
        completion: F.Completion<Model>?
    ) {
        requestService.loadData(query: query) {
            let parsedData = parser($0)
            completion?(parsedData)
        }
    }
}
