//
//  RLMModel.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 14.02.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

import RealmSwift

public class RLMModel: Object {
    
    // MARK: -
    // MARK: Class
    
    @objc open override class func primaryKey() -> String? {
        return "id"
    }
    
    // MARK: -
    // MARK: Properties
    
    @objc dynamic var id = ""
    
    // MARK: -
    // MARK: Public
    
    public func parsedID() -> ID? {
        return self.id
            .split(separator: "_")
            .first
            .map(String.init)
            .flatMap(ID.init)
    }
}
