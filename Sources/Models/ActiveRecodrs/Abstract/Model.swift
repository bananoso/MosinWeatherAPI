//
//  Model.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 14.02.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

import RealmSwift

//public protocol Modelable: class {
//    var id: ID { get }
//}
//
//public class Model: Modelable {
//
//    // MARK: -
//    // MARK: Properties
//
//    public let id: ID
//
//    public var storageID: String {
//        return "\(self.id)_\(typeString(self).lowercased())"
//    }
//
////    public var storage: StorageType {
////        return self.persistence.read(id: self.id)
////    }
//
//    // MARK: -
//    // MARK: Init and Deinit
//
//    public required init(id: ID) {
//        self.id = id
//
////        self.configure()
//    }
//
//    public convenience init(_ id: Int) {
//        self.init(id: ID(id))
//    }
//
//    // MARK: -
//    // MARK: Open
//
////    open func configure() {
////        self.read()
////    }
//}

public class Model<Persistence: Persistable>: Modelable where Persistence.Storage: AnyObject {

    // MARK: -
    // MARK: Subtypes

    public typealias StorageType = Persistence.Storage

    // MARK: -
    // MARK: Properties

    public let id: ID

    public var storageID: String {
        return "\(self.id)_\(typeString(self).lowercased())"
    }

    public var storage: StorageType {
        return self.persistence.read(id: self.id)
    }

    private let lock: NSLocking = NSRecursiveLock()

    private var isInWriteTransaction = false
    private var isInReadTransaction = false

    public let persistence: Persistence

    // MARK: -
    // MARK: Init and Deinit

    public required init(id: ID, persistence: Persistence) {
        self.id = id
        self.persistence = persistence

        self.configure()
    }

    public convenience init(_ id: Int, persistence: Persistence) {
        self.init(id: ID(id), persistence: persistence)
    }

    // MARK: -
    // MARK: Public

    public func read() {
        self.performStorageTransaction(
            excluding: self.isInWriteTransaction,
            condition: { self.isInReadTransaction = $0 },
            action: {
                self.readStorage(self.storage)
            }
        )
    }

    // FIXME: Add actions
    public func write() {
        self.update {
            let storage = self.storage

//            self.writeStorage(storage)
            self.persistence.write(storage: storage, action: self.writeStorage)
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

    open func configure() {
        self.read()
    }

    open func readStorage(_ storage: StorageType) {

    }

    open func writeStorage(_ storage: StorageType) {

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
