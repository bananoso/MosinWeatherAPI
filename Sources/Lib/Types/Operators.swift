//
//  Operators.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 05.02.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

precedencegroup LeftFunctrionApplicationPrecedence {
    associativity: left
    higherThan: AssignmentPrecedence
}

precedencegroup RightFunctrionApplicationPrecedence {
    associativity: right
    higherThan: LeftFunctrionApplicationPrecedence
}

precedencegroup CompositionPrecedence {
    associativity: left
    higherThan: RightFunctrionApplicationPrecedence
}

infix operator •: CompositionPrecedence
func • <A, B, C>(f: @escaping (A) -> B, g: @escaping (B) -> C) -> (A) -> C {
    return { g(f($0)) }
}

func • <A, B, C>(lhs: Lens<A, B>, rhs: Lens<B, C>) -> Lens<A, C> {
    return Lens(from: lhs.from • rhs.from, to: { lhs.to(rhs.to($0, lhs.from($1)), $1) } )
}

//                 LeftFunctrionApplicationPrecedence
infix operator |>: RightFunctrionApplicationPrecedence
func |> <A, B>(value: A, f: (A) -> B) -> B {
    return f § value
}

infix operator §: RightFunctrionApplicationPrecedence
func § <A, B>(f: (A) -> B, value: A) -> B {
    return f(value)
}

//                 RightFunctrionApplicationPrecedence
infix operator <|: LeftFunctrionApplicationPrecedence
func <| <A, B>(f: (A) -> B, value: A) -> B {
    return f § value
}
