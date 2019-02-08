//
//  F.swift
//  Square
//
//  Created by Student on 25.10.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

public enum F {
    
    typealias VoidCompletion = () -> ()
    typealias Completion<Value> = (Value) -> ()
    typealias Predicate<Value> = (Value) -> Bool
}

public func toString(_ cls: AnyClass) -> String {
    return String(describing: cls)
}

public func when<Result>(_ condition: Bool, execute: () -> Result?) -> Result? {
    return condition ? execute() : nil
}

public func unless<Result>(_ condition: Bool, execute: () -> Result?) -> Result? {
    return when(!condition, execute: execute)
}

public func cast<Value, Result>(_ value: Value) -> Result? {
    return value as? Result
}

@discardableResult
public func weakify<Wrapped: AnyObject>(_ value: Wrapped, execute: (Weak<Wrapped>) -> ()) -> Weak<Wrapped> {
    let weak = Weak(value)
    execute(weak)
    
    return weak
}

public func weakify<Wrapped: AnyObject>(_ value: Wrapped) -> Weak<Wrapped> {
    return weakify(value) {_ in }
}

public func dispatchOnMain(_ execute: (() -> ())?) {
    DispatchQueue.main.async {
        execute?()
    }
}

public func identity<Value>(_ value: Value) -> Value {
    return value
}

public func ignoreInput<Value, Result>(_ execute: @escaping () -> Result) -> (Value) -> Result {
    return { _ in
        execute()
    }
}

public func ignoreInOut<Value, Result>(_ execute: @escaping (Value) -> Result) -> (inout Value) -> Result {
    return { execute($0) }
}

public func returnValue<Value>(_ value: Value) -> () -> Value {
    return { value }
}

public func curry<A, B, C>(_ f: @escaping (A, B) -> C) -> (A) -> (B) -> C {
    return { a in
        { f(a, $0) }
    }
}

public func uncurry<A, B, C>(_ f: @escaping (A) -> (B) -> C) -> (A, B) -> C {
    return { f($0)($1) }
}

public func flip<A, B, C>(_ f: @escaping (A) -> (B) -> C) -> (B) -> (A) -> C {
    return { b in
        { f($0)(b) }
    }
}

public func flip<A, B, C>(_ f: @escaping (A, B) -> C) -> (B, A) -> C {
    return { f($1, $0) }
}

public func side<Value>(_ value: Value, execute: (inout Value) -> ()) -> Value {
    var mutableValue = value
    execute(&mutableValue)
    
    return mutableValue
}

public func mapFunc<T>(_ f: ((T) -> ())?) -> (T) -> () {
    return { f?($0) }
}
