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
        if let error = error {
            self = .failure(error)
        }
        
        if let value = value {
            self = .success(value)
        }
        
        self = .failure(`default`)
    }
    
    public func map<NewValue, NewError>(
        success: @escaping (Value) -> NewValue,
        failure: @escaping (Error) -> NewError
        )
        -> Result<NewValue, NewError>
    {
        return self.analysis(success: success • liftSuccess, failure: failure • liftFailure)
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
}

public func liftSuccess<Value, Error: Swift.Error>(_ value: Value) -> Result<Value, Error> {
    return .success(value)
}

public func liftFailure<Value, Error: Swift.Error>(_ error: Error) -> Result<Value, Error> {
    return .failure(error)
}
