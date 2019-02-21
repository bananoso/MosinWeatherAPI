//
//  RealmPersistence.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 15.02.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

import RealmSwift

public class RealmPersistence<Storage: RLMModel>: Persistable {
    
    // MARK: -
    // MARK: Subtypes
    
    public typealias RealmFactory = () -> Realm?
    
    // MARK: -
    // MARK: Properties
    
    private let realmFactory: RealmFactory
    
    // MARK: -
    // MARK: Init and Deinit
    
    public init(realmFactory: @escaping RealmFactory = { Realm.current }) {
        self.realmFactory = realmFactory
    }
    
    // MARK: -
    // MARK: Public
    
    public func read(id: ID) -> Storage {
        let realmId = "\(id)_\(typeString(Storage.self).lowercased())"
        let realm = self.realmFactory()
        
        return realm?.object(ofType: Storage.self, forPrimaryKey: realmId)
            ?? side(Storage()) { storage in
                storage.id = realmId
                realm?.write { $0.add(storage, update: true) }
            }
    }
    
    public func readAll() -> [Storage] {
        return self.realmFactory()?
            .objects(Storage.self)
            .compactMap(identity)
            ?? []
    }
    
    public func write(storage: Storage, action: (Storage) -> ()) {
        self.realmFactory()?.write {
            action(storage)
            
            $0.add(storage, update: true)
        }
    }
    
    public func read<Value>(_ value: Value, to target: inout Value) {
        target = value
    }
    
    public func write<Value>(_ value: Value, to target: inout Value) {
        target = value
    }
}
