//
//  RootViewRepresentable.swift
//  Square
//
//  Created by Mosin Dmitry on 28.12.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import UIKit

protocol RootViewRepresentable {
    
    associatedtype RootView: UIView
}

extension RootViewRepresentable where Self: UIViewController {
    
    var rootView: RootView? {
        return cast(self.viewIfLoaded)
    }
}
