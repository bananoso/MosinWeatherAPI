//
//  NetworkService.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 29.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation
import Alamofire

public enum NetworkServiceError: Error {
    case unknow
    case failed
}

public enum JSONDecoderError: Error {
    case unknow
    case failed
}

class NetworkService {

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

    private var requestService: RequestServiceType

    init(requestService: RequestServiceType) {
        self.requestService = requestService
    }

    @discardableResult
    public func load(countriesModel: Countries) -> NetworkTask {
        return self.loadModel(
            at: Query.allCountries,
            parser: countries,
            sideEffect: ignoreInOut § countriesModel.append
        )
    }

    @discardableResult
    public func loadWeather(country: Country) -> NetworkTask {
        return Query.weather(city: country.capital).map {
            self.loadModel(
                at: $0,
                parser: weather,
                sideEffect: ignoreInOut § ignoreOutput § Country.weatherLens.for § country
            )
        }
        ?? .failed
    }

    private func loadModel<ModelJSON: Decodable, Model>(
        at url: URLConvertible,
        parser: @escaping (ModelJSON) -> Model,
        sideEffect: @escaping (inout Model) -> ()
//        completion: ((Result<Model, NetworkServiceError>) -> ())? = nil
    )
        -> NetworkTask
    {
        return self.requestService.loadData(at: url) { result in
            _ = result.map {
                jsonDecode(data: $0).map(parser • (side <| sideEffect))
            }
            
//            let a = parser(jsonDecode(data: Data()))
//            completion § result.map(jsonDecode • parser)
//            data
//                .flatMap { try? JSONDecoder().decode(ModelJSON.self, from: $0) }
//                .map(parser • (side <| sideEffect))
//                .apply(completion)
        }
    }
}

fileprivate func jsonDecode<ModelJSON: Decodable>(data: Data) -> ModelJSON? {
    return try? JSONDecoder().decode(ModelJSON.self, from: data)
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
