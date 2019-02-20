//
//  DataBaseService.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 18.02.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

import RealmSwift

public protocol DataBaseServiceType {
    
    associatedtype StorageType
    
    func read(id: ID, action: @escaping (StorageType) -> ())
    func readAll(action: @escaping ([StorageType]?) -> ())
    func write(id: ID, action: @escaping (StorageType) -> ())
    func update(action: () -> ())
}

public class DataBaseService<Persistence: Persistable>: DataBaseServiceType
    where Persistence.Storage: AnyObject
{
    
    // MARK: -
    // MARK: Subtypes
    
    public typealias StorageType = Persistence.Storage
    
    // MARK: -
    // MARK: Properties
    
    public let persistence: Persistence
    
    private var isInWriteTransaction = false
    private var isInReadTransaction = false
    
    private let lock: NSLocking = NSRecursiveLock()
    
    // MARK: -
    // MARK: Init and Deinit
    
    public init(persistence: Persistence) {
        self.persistence = persistence
    }
    
    // MARK: -
    // MARK: Public
    
    public func read(id: ID, action: @escaping (StorageType) -> ()) {
        self.performStorageTransaction(
            excluding: self.isInWriteTransaction,
            condition: { self.isInReadTransaction = $0 },
            action: {
                let storage = self.persistence.read(id: id)
                
                self.readStorage(storage)
                action(storage)
            }
        )
    }
    
    public func readAll(action: @escaping ([StorageType]?) -> ()) {
        self.performStorageTransaction(
            excluding: self.isInWriteTransaction,
            condition: { self.isInReadTransaction = $0 },
            action: {
                let storages = self.persistence.readAll()
                
                storages?.forEach(self.readStorage)
                action(storages)
            }
        )
    }
    
    public func write(id: ID, action: @escaping (StorageType) -> ()) {
        self.update {
            let storage = self.persistence.read(id: id)
            
            self.writeStorage(storage)
            self.persistence.write(storage: storage, action: action)
        }
    }
    
    public func update(action: () -> ()) {
        self.performStorageTransaction(
            excluding: self.isInReadTransaction,
            condition: { self.isInWriteTransaction = $0 },
            action: action
        )
    }
    
    // MARK: -
    // MARK: Open

    open func writeStorage(_ storage: StorageType) {
        
    }
    
    open func readStorage(_ storage: StorageType) {
        
    }
    
    // MARK: -
    // MARK: Private
    
    private func performStorageTransaction(
        excluding: @autoclosure () -> Bool,
        condition: (Bool) -> (),
        action: () -> ()
        ) {
        self.lock.locked {
            if excluding() {
                return
            }
            
            condition(true)
            action()
            condition(false)
        }
    }
}
