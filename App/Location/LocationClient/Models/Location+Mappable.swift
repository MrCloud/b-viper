//
//  Location+Mappable.swift
//  Weather
//
//  Created by Florian PETIT on 23/06/2017.
//  Copyright © 2017 MTT. All rights reserved.
//

import Mapper

extension Location: Mappable {
    public init(map: Mapper) throws {
        try locationId = map.from("id", transformation: { return String(describing: $0) })
        try name = map.from("name")
        try region = map.from("region")
        try country = map.from("country")
        try latitude = map.from("lat")
        try longitude = map.from("lon")
    }
}
