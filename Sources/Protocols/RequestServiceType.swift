//
//  RequestServiceType.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 07.02.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

import Alamofire

public protocol RequestServiceType {
    
    func loadData(
        at url: URLConvertible,
        completion: @escaping (Result<Data, RequestServiceError>) -> ()
    )
        -> NetworkTask
}
