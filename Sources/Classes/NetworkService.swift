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

public class CountriesNetworkService<DataBaseService: DataBaseServiceType>
    where DataBaseService.StorageType == RLMCountry
{
    
    // MARK: -
    // MARK: Properties
    
    private let allCountriesQuery = "https://restcountries.eu/rest/v2/all"
    private let requestService: RequestServiceType
    private let dataBaseService: DataBaseService
    private let idProvider: IDProvider
    
    // MARK: -
    // MARK: Init and Deinit
    
    public init(
        requestService: RequestServiceType,
        dataBaseService: DataBaseService,
        idProvider: @escaping IDProvider = autoInctementedProvider(start: 0)
    ) {
        self.requestService = requestService
        self.dataBaseService = dataBaseService
        self.idProvider = idProvider
    }
    
    // MARK: -
    // MARK: Public
    
    @discardableResult
    public func load(countriesModel: Countries) -> NetworkTask {
        return self.requestService.loadData(at: self.allCountriesQuery) { result in
            result.analysis(
                success: {
                    let countriesArray = decodedJson($0).map(self.countries)
                    
                    countriesArray.do(countriesModel.append)
                    
                    countriesArray?.forEach { country in
                        self.dataBaseService.write(id: country.id) {
                            $0.name = country.name
                            $0.capital = country.capital
                        }
                    }
                },
                failure: { _ in
                    self.dataBaseService.readAll {
                        $0.map(self.countries).do(countriesModel.append)
                    }
                }
            )
        }
    }
    
    // MARK: -
    // MARK: Private
    
    private func countries(rlmCounties: [RLMCountry]) -> [Country] {
        return rlmCounties
            .map { rlmCountry in
                self.id(rlmCountry: rlmCountry).map {
                    Country(id: $0, name: rlmCountry.name, capital: rlmCountry.capital)
                }
            }
            .compactMap(identity)
    }
    
    private func id(rlmCountry: RLMCountry) -> ID? {
        let stringID = rlmCountry
            .id
            .split(separator: "_")
            .first
            .map(String.init)
        
        let idNumber = stringID.map(Int.init).flatten()
        
        return idNumber.map { ID($0) }
    }
    
    private func countries(jsons: [CountryJSON]) -> [Country] {
        return jsons
            .filter { !$0.capital.isEmpty }
            .map(country)
    }
    
    private func country(json: CountryJSON) -> Country {
        return Country(id: self.idProvider(), name: json.name, capital: json.capital)
    }
}

public class WeatherNetworkService<DataBaseService: DataBaseServiceType>
    where DataBaseService.StorageType == RLMWeather
{
    
    // MARK: -
    // MARK: Subtypes
    
    private struct Query {

        static func weather(city: String) -> String? {
            return city
                .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                .map(self.cityWeather)
        }
    
        static private func cityWeather(_ city: String) -> String {
            return "https://api.openweathermap.org/data/2.5/weather?q="
                + city
                + "&units=metric&appid=5372fc075a669c8e7a76effda37c5eb5"
        }
    }
    
    // MARK: -
    // MARK: Properties
    
    private let requestService: RequestServiceType
    private let dataBaseService: DataBaseService
    private let idProvider: IDProvider
    
    // MARK: -
    // MARK: Init and Deinit
    
    public init(
        requestService: RequestServiceType,
        dataBaseService: DataBaseService,
        idProvider: @escaping IDProvider = autoInctementedProvider(start: 0)
        ) {
        self.requestService = requestService
        self.dataBaseService = dataBaseService
        self.idProvider = idProvider
    }
    
    // MARK: -
    // MARK: Public
    
    @discardableResult
    public func loadWeather(country: Country) -> NetworkTask {
        
        return Query.weather(city: country.capital).map {
            self.requestService.loadData(at: $0) { result in
                
                result.analysis(
                    success: {
                        let weather = decodedJson($0).map(self.weather)
                        
                        country.weather = weather
                        
                        self.dataBaseService.write(id: country.id) {
                            $0.temperature.value = weather?.temperature
                            $0.updateDate = weather?.updateDate
                        }
                    },
                    failure: {
                        self.dataBaseService.read(id: country.id) { rlmWeather in
                            rlmWeather.temperature.value.do { temperature in
                                rlmWeather.updateDate.do {
                                    country.weather = Weather(temperature: temperature, updateDate: $0)
                                }
                            }
                        }
                        
                        print($0.localizedDescription)
                    }
                )
                
//                _ = result.map {
//                    let weather = decodedJson($0).map(self.weather)
//
//                    country.weather = weather
//
//                    self.dataBaseService.write(id: country.id) {
//                        $0.temperature.value = weather?.temperature
//                        $0.updateDate = weather?.updateDate
//                    }
//                }
            }
        }
        ?? .failed
    }
    
    // MARK: -
    // MARK: Private
    
    private func weather(json: WeatherJSON) -> Weather {
        return Weather(
            temperature: json.main.temp.int ?? 0,
            updateDate: Date(timeIntervalSince1970: json.dt)
        )
    }
}

fileprivate func decodedJson<ModelJSON: Decodable>(_ data: Data) -> ModelJSON? {
    return try? JSONDecoder().decode(ModelJSON.self, from: data)
}


//public class NetworkService {
//
//    // MARK: -
//    // MARK: Subtypes
//    
//    private struct Query {
//
//        static let allCountries = "https://restcountries.eu/rest/v2/all"
//
//        static func weather(city: String) -> String? {
//            return city
//                .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//                .map(self.cityWeather)
//        }
//        
//        private static let cityWeather: (String) -> String = {
//            "https://api.openweathermap.org/data/2.5/weather?q="
//                + $0
//                + "&units=metric&appid=5372fc075a669c8e7a76effda37c5eb5"
//        }
//    }
//
//    // MARK: -
//    // MARK: Properties
//    
//    private var requestService: RequestServiceType
//
//    // MARK: -
//    // MARK: Init and Deinit
//    
//    public init(requestService: RequestServiceType) {
//        self.requestService = requestService
//    }
//
//    // MARK: -
//    // MARK: Public
//    
//    @discardableResult
//    public func load(countriesModel: Countries) -> NetworkTask {
//        return self.loadModel(
//            at: Query.allCountries,
//            parser: countries,
//            sideEffect: {
//                ($0 as? Country).do(countriesModel.append)
//                
//            }
//        )
//    }
//
//    @discardableResult
//    public func loadWeather(country: Country) -> NetworkTask {
//        return Query.weather(city: country.capital).map {
//            self.loadModel(
//                at: $0,
//                parser: weather,
//                sideEffect: ignoreInOut § ignoreOutput § Country.weatherLens.for § country
//            )
//        }
//        ?? .failed
//    }
//
//    // MARK: -
//    // MARK: Private
//    
//    private func loadModel<ModelJSON: Decodable, Model>(
//        at url: URLConvertible,
//        parser: @escaping (ModelJSON) -> Model,
//        sideEffect: @escaping (inout Model) -> ()
////        completion: ((Result<Model, NetworkServiceError>) -> ())? = nil
//    )
//        -> NetworkTask
//    {
//        return self.requestService.loadData(at: url) { result in
//            _ = result.map {
//                jsonDecode(data: $0).map(parser • (side <| sideEffect))
//            }
//            
////            let a = parser(jsonDecode(data: Data()))
////            completion § result.map(jsonDecode • parser)
////            data
////                .flatMap { try? JSONDecoder().decode(ModelJSON.self, from: $0) }
////                .map(parser • (side <| sideEffect))
////                .apply(completion)
//        }
//    }
//}
