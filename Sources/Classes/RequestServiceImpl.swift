//
//  RequestServiceImpl.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 07.02.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

public enum RequestServiceError: Error {
    case failed
}

class RequestServiceImpl: RequestService {
    
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func loadData(at url: URL, completion: @escaping (Data?, Error?) -> ()) -> NetworkTask {
        return self.session.resumedDataTask(with: url) { data, response, error in
            switch (data, error) {
            case (nil, nil): completion(nil, RequestServiceError.failed)
            default: completion(data, error)
            }
        }
    }
}
