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
    
    public var model: Model?
    
    private(set) var state: State = .notLoaded {
        didSet {
            self.notify(property: self.state)
        }
    }
    
    func loadData(url: URL) {
        self.state = .didStartLoading
        
        URLSession.shared.resumeDataTask(with: url) { data, response, error in
            if error != nil {
                error.do { self.state = .didFailedWithError($0) }
                
                return
            }
            
            data.flatMap { try? JSONDecoder().decode(Model.self, from: $0) }
                .map {
                    self.model = $0
                    self.state = .didLoad
                }
                .ifNil { self.state = .didFailedWithError(JSONDecoder.DecoddingError.invalidModel) }
        }
    }
}
