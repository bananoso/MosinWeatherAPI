//
//  RealmDataBaseService.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 18.02.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

import RealmSwift

public class RealmDataBaseService<RLMModel: WeatherAPI.RLMModel>: DataBaseServiceType
    where RLMModel: ModelConvertable, RLMModel.Model: Modelable
{
    
    // MARK: -
    // MARK: Subtypes
    
    public typealias Model = RLMModel.Model
    
    // MARK: -
    // MARK: Properties
    
    private let persistence = RealmPersistence<RLMModel>()
    
    // MARK: -
    // MARK: Public
    
    public func read(id: ID) -> Model? {
        return self.persistence.read(id: id).model
    }
    
    public func readAll() -> [Model] {
        return self.persistence.readAll()
            .compactMap { $0.model }
    }
    
    public func write(storage: Model) {
        let rlmModel = self.persistence.read(id: storage.id)

        self.persistence.write(storage: rlmModel) {
            self.writeStorage($0, storage: storage)
        }
    }
    

    // MARK: -
    // MARK: Open
    
    open func writeStorage(_ rlmStorage: RLMModel, storage: Model) {
        
    }
}
