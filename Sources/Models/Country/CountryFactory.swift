//
//  CountryFactory.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 18.02.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

//public protocol CountryFactory {
//
//    func country() -> CountryType
//    func country(id: ID) -> CountryType
//}

fileprivate let key = "com.weatherapi.country.defaults.key"
fileprivate let idFactory = autoInctementedID(key: key)

//extension CountryFactory {
//
//    // MARK: -
//    // MARK: Public
//
//    public func country() -> CountryType {
//        return self.country(id: idFactory())
//    }
//}

public class CountryRealmFactory {
    
    // MARK: -
    // MARK: Public
    
    public func country() -> RLMCountry {
        return self.country(id: idFactory())
    }
    
    public func country(id: ID) -> RLMCountry {
        let rlmCountry = RLMCountry()
        rlmCountry.id = id.description
        
        return rlmCountry
    }
}
