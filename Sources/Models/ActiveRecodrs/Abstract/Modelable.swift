//
//  Modelable.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 20.02.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

public protocol Modelable: class {
    
    var id: ID { get }
    
//    func read()
//    func write()
//    func update(action: () -> ())
}
