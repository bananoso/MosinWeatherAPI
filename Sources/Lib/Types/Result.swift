//
//  Result.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 05.02.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

public enum Result<Value, Error: Swift.Error> {
    case success(Value)
    case failure(Error)
    
    private static func materialize(value: Value?, error: Error?, `default`: Error) -> Result {
        switch (value, error) {
        case let (_, error?): return .failure(error)
        case let (value?, nil): return .success(value)
        default: return .failure(`default`)
        }
    }
    
    public var value: Value? {
        return self.optional § self.analysis
    }
    
    public var error: Error? {
//        return self.optional § flip § self.analysis
        return self.analysis(success: ignoreInput § returnValue § nil, failure: identity)
    }
    
    private func optional<Ignored, Result>(_ f: ((Result) -> Result?, (Ignored) -> Result?) -> Result?) -> Result? {
        return f(identity, ignoreInput § returnValue § nil)
    }
    
    public init(value: Value?, error: Error?, `default`: Error) {
        self = Result.materialize(value: value, error: error, default: `default`)
    }
    
    public func analysis<ReturnType>(
        success: (Value) -> ReturnType,
        failure: (Error) -> ReturnType
    )
        -> ReturnType
    {
        switch self {
        case let .success(wrapped): return success(wrapped)
        case let .failure(wrapped): return failure(wrapped)
        }
    }
    
    public func bimap<NewValue, NewError>(
        success: (Value) -> NewValue,
        failure: (Error) -> NewError
    )
        -> Result<NewValue, NewError>
    {
        return withoutActuallyEscaping(success) { success in
            withoutActuallyEscaping(failure) { failure in
                self.analysis(success: success • lift, failure: failure • lift)
            }
        }
    }
    
    // TODO: flip optional
    public func map<NewValue>(_ transform: (Value) -> NewValue) -> Result<NewValue, Error> {
        return self.bimap(success: transform, failure: identity)
    }
    
    public func mapError<NewError>(_ transform: (Error) -> NewError) -> Result<Value, NewError> {
        return self.bimap(success: identity, failure: transform)
    }
    
    public func biflatMap<NewValue, NewError>(
        success: (Value) -> Result<NewValue, NewError>,
        failure: (Error) -> Result<NewValue, NewError>
    )
        -> Result<NewValue, NewError>
    {
        return self.analysis(success: success, failure: failure)
    }
    
    public func flatMap<NewValue>(_ transform: (Value) -> Result<NewValue, Error>) -> Result<NewValue, Error> {
        return self.biflatMap(success: transform, failure: lift)
    }
    
    public func flatMapError<NewError>(_ transform: (Error) -> Result<Value, NewError>) -> Result<Value, NewError> {
        return self.biflatMap(success: lift, failure: transform)
    }
}
public func lift<Value, Error: Swift.Error>(_ value: Value) -> Result<Value, Error> {
    return .success(value)
}

public func lift<Value, Error: Swift.Error>(_ error: Error) -> Result<Value, Error> {
    return .failure(error)
}
