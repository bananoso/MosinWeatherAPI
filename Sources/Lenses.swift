//
//  Lenses.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 11.02.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

public enum Lenses {
    
    static let weather = Lens<Country, Weather?>(
        from: { $0.weather },
        to: {
            $1.weather = $0
            
            return $1
        }
    )
}
