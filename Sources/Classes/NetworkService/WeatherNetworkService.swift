//
//  WeatherNetworkService.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 21.02.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

import Alamofire

public class WeatherNetworkService<DataBaseService: DataBaseServiceType>: NetworkService<DataBaseService>
    where DataBaseService.StorageType == Weather
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
    // MARK: Public
    
    @discardableResult
    public func loadWeather(country: Country) -> NetworkTask {
        return Query.weather(city: country.capital).map {
            self.requestService.loadData(at: $0) {
                $0.analysis(
                    success: {
                        country.weather = decodedJson($0)
                            .map { self.weather(json: $0, country: country) }
                    },
                    failure: { _ in
                        country.weather = self.dataBaseService.read(id: country.id)
                    }
                )
            }
        }
        ?? .failed
    }
    
    // MARK: -
    // MARK: Private
    
    private func weather(json: WeatherJSON, country: Country) -> Weather {
        return Weather(
            id: country.id,
            temperature: json.main.temp.int ?? 0,
            updateDate: Date(timeIntervalSince1970: json.dt)
        )
    }
}
