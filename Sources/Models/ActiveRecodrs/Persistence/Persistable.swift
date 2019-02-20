//
//  Persistable.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 15.02.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

public protocol Persistable {
    
    associatedtype Storage
    
    func read(id: ID) -> Storage
    func readAll() -> [Storage]?
    
    func write(storage: Storage, action: (Storage) -> ())
    
    func read<Value>(_ value: Value, to target: inout Value)
    func write<Value>(_ value: Value, target: inout Value)
}
