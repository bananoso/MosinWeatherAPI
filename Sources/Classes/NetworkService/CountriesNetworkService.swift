//
//  CountriesNetworkService.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 21.02.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

import Alamofire

public class CountriesNetworkService<DataBaseService: DataBaseServiceType>: NetworkService<DataBaseService>
    where DataBaseService.StorageType == Country
{
    
    // MARK: -
    // MARK: Properties
    
    private let allCountriesQuery = "https://restcountries.eu/rest/v2/all"
    
    // MARK: -
    // MARK: Public
    
    @discardableResult
    public func load(countriesModel: Countries) -> NetworkTask {
        return self.requestService.loadData(at: self.allCountriesQuery) {
            $0.analysis(
                success: {
                    let rlmCountries = decodedJson($0).map(self.countries)
                    rlmCountries?.forEach { country in
                        country.observer { _ in
                            country.weather.do { _ in
                                self.dataBaseService.write(storage: country)
                            }
                        }
                    }
                    
                    rlmCountries.do(countriesModel.append)
                    rlmCountries?.forEach(self.dataBaseService.write)
                },
                failure: { _ in
                    countriesModel.append § self.dataBaseService.readAll()
                }
            )
        }
    }
    
    // MARK: -
    // MARK: Private
    
    private func countries(jsons: [CountryJSON]) -> [Country] {
        return jsons
            .filter { !$0.capital.isEmpty }
            .map(country)
    }
    
    private func country(json: CountryJSON) -> Country {
        return Country(id: self.idProvider(), name: json.name, capital: json.capital)
    }
}
