//
//  RequestService.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 07.02.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

import Alamofire

public enum RequestServiceError: Error {
    case unknown
    case failed
}

public class RequestService: RequestServiceType {
    
    // MARK: -
    // MARK: Properties
    
    private let session: URLSession
    
    // MARK: -
    // MARK: Init and Deinit
    
    public init(session: URLSession) {
        self.session = session
    }
    
    // MARK: -
    // MARK: Public
    
    public func loadData(
        at url: URLConvertible,
        completion: @escaping (Result<Data, RequestServiceError>) -> ()
    )
        -> NetworkTask
    {
        let dataRequest = request(url).response {
            completion § Result(
                value: $0.data,
                error:  $0.error.map(ignoreInput § returnValue § .failed),
                default: .unknown
            )
        }
        
        defer {
            dataRequest.resume()
        }
        
        return dataRequest.task.map(NetworkTask.init) ?? .failed
    }
}
