//
//  Parser.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 14.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

class NetworkManager<Model: Decodable>: ObservableObject<NetworkManager.State> {
    
    public enum State {
        case didStartLoading
        case didLoad
        case didFailedWithError(_ error: Error)
    }
    
    public func loadData(query: String, completion: F.Completion<Model?>? = nil) {
        URL(query: query).do {
            self.loadData(url: $0, completion: completion)
        }
    }
    
    public func loadData(url: URL, completion: F.Completion<Model?>? = nil) {
        self.notify(.didStartLoading)
        
        URLSession.shared.resumeDataTask(with: url) { data, response, error in
            error.ifNil { self.load(data: data, completion: completion) }
                .map { self.notify(.didFailedWithError($0)) }
        }
    }
    
    private func load(data: Data?, completion: F.Completion<Model?>?) {
        data.flatMap { try? JSONDecoder().decode(Model.self, from: $0) }
            .ifNil { self.notify(.didFailedWithError(JSONDecoder.DecoddingError.modelParsingError)) }
            .map {
                completion?($0)
                self.notify(.didLoad)
            }
    }
}
