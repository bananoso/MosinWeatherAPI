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
        case notLoaded
        case didStartLoading
        case didLoad
        case didFailedWithError(_ error: Error)
    }
    
    private(set) var state: State = .notLoaded {
        didSet {
            self.notify(property: self.state)
        }
    }
    
    func loadData(url: URL, completion: F.Completion<Model?>? = nil) {
        self.state = .didStartLoading
        
        URLSession.shared.resumeDataTask(with: url) { data, response, error in
            error.ifNil { self.load(data: data, completion: completion) }
                .map { self.state = .didFailedWithError($0) }
        }
    }
    
    private func load(data: Data?, completion: F.Completion<Model?>?) {
        data.flatMap { try? JSONDecoder().decode(Model.self, from: $0) }
            .ifNil { self.state = .didFailedWithError(JSONDecoder.DecoddingError.invalidModel) }
            .map {
                completion?($0)
                self.state = .didLoad
            }
    }
}
