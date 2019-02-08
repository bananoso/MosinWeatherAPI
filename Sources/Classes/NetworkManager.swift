//
//  NetworkManager.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 29.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

class NetworkManager {

    private struct Query {

        static let allCountries = "https://restcountries.eu/rest/v2/all"

        static func weather(city: String) -> String? {
            return city
                .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                .map(self.cityWeather)
        }
        
        private static let cityWeather: (String) -> String = {
            "https://api.openweathermap.org/data/2.5/weather?q="
                + $0
                + "&units=metric&appid=5372fc075a669c8e7a76effda37c5eb5"
        }
    }

    private var requestService: RequestService

    init(requestService: RequestService) {
        self.requestService = requestService
    }

    @discardableResult
    public func load(
        countriesModel: Countries,
        _ completion: F.Completion<[Country]>? = nil
    )
        -> NetworkTask?
    {
        return URL(string: Query.allCountries).map {
            self.loadModel(
                at: $0,
                parser: { side(countries($0), execute: ignoreInOut § countriesModel.append) },
                completion: completion
            )
        }
    }

    @discardableResult
    public func loadWeather(
        country: Country,
        completion: F.Completion<Weather>? = nil
    )
        -> NetworkTask?
    {
        return Query
            .weather(city: country.capital)
            .flatMap(URL.init)
            .map {
                self.loadModel(
                    at: $0,
                    parser: {
                        side(weather($0)) {
                            country.weather = $0
                        }
                    },
                    completion: completion
                )
        }
    }

    private func loadModel<ModelJSON: Decodable, Model>(
        at url: URL,
        parser: @escaping (ModelJSON) -> Model,
        completion: F.Completion<Model>?
    )
        -> NetworkTask
    {
        return self.requestService.loadData(at: url) { data, error in
            data
                .flatMap { try? JSONDecoder().decode(ModelJSON.self, from: $0) }
                .do(parser • (mapFunc § completion))
        }
    }
}

fileprivate let country: (CountryJSON) -> Country = {
    Country(name: $0.name, capital: $0.capital)
}

fileprivate let countries: ([CountryJSON]) -> [Country] = { jsons in
    jsons
        .filter { !$0.capital.isEmpty }
        .map(country)
}

fileprivate let weather: (WeatherJSON) -> Weather = {
    Weather(
        temperature: $0.main.temp.int ?? 0,
        updateDate: Date(timeIntervalSince1970: $0.dt)
    )
}
