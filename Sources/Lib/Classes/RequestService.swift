//
//  RequestService.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 29.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

class RequestService<Model: Decodable> {
    
    public func loadData(query: String, completion: @escaping F.Completion<Model>) {
        URL(query: query).do {
            self.loadData(url: $0, completion: completion)
        }
    }
    
    public func loadData(url: URL, completion: @escaping F.Completion<Model>) {
        URLSession.shared.resumeDataTask(with: url) { data, response, error in
            error.ifNil { self.load(data: data, completion: completion) }
        }
    }
    
    public func load(data: Data?, completion: F.Completion<Model>) {
        data
            .flatMap { try? JSONDecoder().decode(Model.self, from: $0) }
            .do(completion)
    }
}
