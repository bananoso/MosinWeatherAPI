//
//  CGRect+Extensions.swift
//  Square
//
//  Created by Mosin Dmitry on 28.12.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import CoreGraphics

extension CGRect {
    
    public enum Position {
        case topLeft
        case topRight
        case bottomRight
        case bottomLeft
        case leftCenter
        case rightCenter
        case center
        case topCenter
        case bottomCenter
    }
    
    public var topLeft: CGPoint {
        return CGPoint(x: self.minX, y: self.minY)
    }
    
    public var topRight: CGPoint {
        return CGPoint(x: self.maxX, y: self.minY)
    }
    
    public var bottomRight: CGPoint {
        return CGPoint(x: self.maxX, y: self.maxY)
    }
    
    public var bottomLeft: CGPoint {
        return CGPoint(x: self.minX, y: self.maxY)
    }
    
    public var leftCenter: CGPoint {
        return CGPoint(x: self.minX, y: self.midY)
    }
    
    public var rightCenter: CGPoint {
        return CGPoint(x: self.maxX, y: self.midY)
    }
    
    public var center: CGPoint {
        return CGPoint(x: self.midX, y: self.midY)
    }
    
    public var topCenter: CGPoint {
        return CGPoint(x: self.midX, y: self.minY)
    }
    
    public var bottomCenter: CGPoint {
        return CGPoint(x: self.midX, y: self.maxY)
    }
    
    public func point(at position: Position) -> CGPoint {
        switch position {
        case .topLeft: return self.topLeft
        case .topRight: return self.topRight
        case .bottomRight: return self.bottomRight
        case .bottomLeft: return self.bottomLeft
        case .leftCenter: return self.leftCenter
        case .rightCenter: return self.rightCenter
        case .center: return self.center
        case .topCenter: return self.topCenter
        case .bottomCenter: return self.bottomCenter
        }
    }
}
