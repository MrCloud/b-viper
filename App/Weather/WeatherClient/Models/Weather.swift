//
//  Weather.swift
//  Weather
//
//  Created by Florian PETIT on 23/06/2017.
//  Copyright © 2017 MTT. All rights reserved.
//

import Foundation

public struct Weather {
    public let locationName: String
    public let temperature: String
    public let forecastInDays: [String]
    public let temperatureUnit: String
}

extension Weather: Equatable {
    static public func == (lhs: Weather, rhs: Weather) -> Bool {
        return lhs.locationName == rhs.locationName && lhs.temperature == rhs.temperature
            && lhs.forecastInDays == rhs.forecastInDays && lhs.temperatureUnit == rhs.temperatureUnit
    }
}
