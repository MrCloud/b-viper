//
//  Location.swift
//  Weather
//
//  Created by Florian PETIT on 23/06/2017.
//  Copyright © 2017 MTT. All rights reserved.
//

import Foundation

/// The Location model
public struct Location {
    public let locationId: String
    public let name: String
    public let region: String
    public let country: String
    public let latitude: Double?
    public let longitude: Double?
}
