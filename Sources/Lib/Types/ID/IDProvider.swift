//
//  IDProvider.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 15.02.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

public typealias IDProvider = () -> ID

public func autoInctementedProvider(start: Int) -> IDProvider {
    return autoInctementedID(start: start)
}

fileprivate let persistenProvider = Atomic([String: IDProvider]())

public func autoInctementedID(key: String) -> IDProvider {
    return persistenProvider.modify { storage in
        storage[key] ?? call {
            let defaults = UserDefaults.standard
            
            let result = autoInctementedID(start: defaults.integer(forKey: key)) {
                defaults.set($0, forKey: key)
            }
            
            storage[key] = result
            
            return result
        }
    }
}

private func autoInctementedID(start: Int, action: ((Int) -> ())? = nil) -> IDProvider {
    let value = Atomic(start)
    
    return {
        value.modify {
            let result = $0
            $0 += 1
            action?($0)
            
            return ID(result)
        }
    }
}
