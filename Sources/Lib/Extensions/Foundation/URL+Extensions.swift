//
//  URL+Extensions.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 16.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

extension URL {
    
    init?(query: String, withAllowedCharacters: CharacterSet = .urlQueryAllowed) {
        let encodingQuery = query.addingPercentEncoding(withAllowedCharacters: withAllowedCharacters)
        guard let urlString = encodingQuery else { return nil }
        
        self.init(string: urlString)
    }
}
