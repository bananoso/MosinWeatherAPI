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

class RequestService: RequestServiceType {
    
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func loadData(at url: URLConvertible, completion: @escaping (Result<Data, RequestServiceError>) -> ()) -> NetworkTask {
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
        
//        return self.session.resumedDataTask(with: url) { data, response, error in
//            completion § Result(
//                value: data,
//                error:  error.map(ignoreInput § returnValue § .failed),
//                default: .unknown
//            )
//        }
    }
}
