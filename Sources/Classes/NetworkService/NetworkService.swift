//
//  NetworkService.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 29.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

public class NetworkService<DataBaseService: DataBaseServiceType> {
    
    // MARK: -
    // MARK: Properties
    
    public let requestService: RequestServiceType
    public let dataBaseService: DataBaseService
    public let idProvider: IDProvider
    
    // MARK: -
    // MARK: Init and Deinit
    
    public init(
        requestService: RequestServiceType,
        dataBaseService: DataBaseService,
        idProvider: @escaping IDProvider = autoInctementedProvider(start: 0)
    ) {
        self.requestService = requestService
        self.dataBaseService = dataBaseService
        self.idProvider = idProvider
    }
}
