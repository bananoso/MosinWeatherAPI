//
//  Queue.swift
//  Square
//
//  Created by Student on 29.10.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

class Queue<Element> {
    
    private let elements: Atomic<[Element]>
    
    public init(_ elements: [Element] = []) {
        self.elements = Atomic(elements)
    }
    
    public var count: Int {
        return self.elements.value.count
    }
    
    public var isEmpty: Bool {
        return self.elements.value.isEmpty
    }
    
    public func dequeue() -> Element? {
        return self.elements.modify {
            $0.safeRemoveFirst()
        }
    }

    public func enqueue(_ value: Element) {
        self.elements.modify {
            $0.append(value)
        }
    }
}
