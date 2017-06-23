//
//  LocationListViewModelBuilder.swift
//  Weather
//
//  Created by Florian PETIT on 23/06/2017.
//  Copyright © 2017 MTT. All rights reserved.
//

import LocationClient

struct LocationListViewModelBuilder {
    
    func buildViewModel(_ locations: [Location]) -> LocationListViewModel {
        let locationViewModels = locations.map { (location) -> LocationViewModel in
            return LocationViewModel(locationId: location.locationId,
                                     name: location.name,
                                     detail: self.detailTextFromLocationData(location))
        }
        
        return LocationListViewModel(locations: locationViewModels)
    }
    
    fileprivate func detailTextFromLocationData(_ location: Location) -> String {
        if location.region.isEmpty {
            return location.country
        }
        return "\(location.region), \(location.country)"
    }
    
}
