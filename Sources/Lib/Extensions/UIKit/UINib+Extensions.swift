//
//  UINib+Extensions.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 15.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import UIKit

extension UINib {
    
    convenience init(_ viewClass: AnyClass, bundle: Bundle? = nil) {
        self.init(nibName: toString(viewClass), bundle: bundle)
    }
}
