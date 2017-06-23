//
//  RealmLocation.swift
//  Weather
//
//  Created by Florian PETIT on 23/06/2017.
//  Copyright © 2017 MTT. All rights reserved.
//

import RealmSwift

class RealmLocation: Object {
    dynamic var locationId: String = ""
    dynamic var name: String = ""
    dynamic var region: String = ""
    dynamic var country: String = ""
    var latitude = RealmOptional<Double>()
    var longitude = RealmOptional<Double>()
}
