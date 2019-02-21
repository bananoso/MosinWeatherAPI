//
//  Realm+Extensions.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 14.02.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

import RealmSwift

public struct WeakBox<Wrapped: AnyObject> {
    
    // MARK: -
    // MARK: Properties
    
    public var isEmpty: Bool {
        return self.wrapped == nil
    }
    
    public private(set) weak var wrapped: Wrapped?
    
    // MARK: -
    // MARK: Init and Deinit
    
    init(_ wrapped: Wrapped?) {
        self.wrapped = wrapped
    }
}

extension WeakBox: Equatable {
    
    public static func ==(rhs: WeakBox, lhs: WeakBox) -> Bool {
        return lhs
            .wrapped.flatMap { lhs in
                rhs.wrapped.map { $0 === lhs }
            }
            ?? false
    }
}

public extension Realm {
    
    // MARK: -
    // MARK: Subtypes
    
    private struct Key {
        static let realm = "com.realm.thread.key"
    }
    
    // MARK: -
    // MARK: Properties
    
    public static var current: Realm? {
        let key = Key.realm
        let thread = Thread.current
        
        return thread.threadDictionary[key]
            .flatMap { $0 as? WeakBox<Realm> }
            .flatMap { $0.wrapped }
            ?? call {
                (try? Realm()).map(
                    sideEffect { thread.threadDictionary[key] = WeakBox($0) }
                )
            }
    }
    
    // MARK: -
    // MARK: Public
    
    public static func clearCurrent() {
        Thread.current.threadDictionary[Key.realm] = nil
    }
    
    public static func write(_ action: (Realm) -> ()) {
        self.current.do { $0.write(action) }
    }
    
    public func write(_ action: (Realm) -> ()) {
        if self.isInWriteTransaction {
            action(self)
        } else {
            try? self.write { action(self) }
        }
    }
}
