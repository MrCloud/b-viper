//
//  Weather+Mappable.swift
//  Weather
//
//  Created by Florian PETIT on 23/06/2017.
//  Copyright © 2017 MTT. All rights reserved.
//

import Foundation
import Mapper

extension Weather: Mappable {
    
    public init(map: Mapper) throws {
        try locationName = map.from("location.name")
        
        try temperature = map.from("current.temp_c", transformation: { return String(describing: $0) })
        forecastInDays = ["20", "21", "22", "19", "20"]
        temperatureUnit = "°C"
    }
}
