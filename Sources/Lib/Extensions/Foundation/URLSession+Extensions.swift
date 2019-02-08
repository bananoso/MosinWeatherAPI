//
//  URLSession+Extensions.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 15.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

extension URLSession {
    
    func resumedDataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> ()) -> NetworkTask {
        let dataTask = self.dataTask(with: url, completionHandler: completionHandler)
        dataTask.resume()
        
        return NetworkTask(dataTask)
    }
    
    func resumeDataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> ()) {
        self.dataTask(with: url, completionHandler: completionHandler).resume()
    }
}
