//
//  RequestService.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 07.02.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

protocol RequestService {
    
    func loadData(at url: URL, completion: @escaping (Data?, Error?) -> ()) -> NetworkTask
}
