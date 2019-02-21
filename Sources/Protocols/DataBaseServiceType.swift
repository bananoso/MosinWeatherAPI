//
//  DataBaseServiceType.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 21.02.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

public protocol DataBaseServiceType {
    
    associatedtype StorageType
    
    func read(id: ID) -> StorageType?
    func readAll() -> [StorageType]
    
    func write(storage: StorageType)
}
