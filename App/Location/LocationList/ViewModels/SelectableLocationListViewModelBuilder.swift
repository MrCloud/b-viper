//
//  SelectableLocationListViewModelBuilder.swift
//  Weather
//
//  Created by Florian PETIT on 23/06/2017.
//  Copyright © 2017 MTT. All rights reserved.
//

import LocationClient

struct SelectableLocationListViewModelBuilder {
    
    func buildViewModel(_ locations: [Location]) -> SelectableLocationListViewModel {
        let locationsViewModels = locations.map(self.mapLocation)
        return SelectableLocationListViewModel(locations: locationsViewModels)
    }
    
    fileprivate func mapLocation(_ location: Location) -> SelectableLocationViewModel {
        return SelectableLocationViewModel(locationId: location.locationId,
                                           name: location.name,
                                           detail: self.detailTextFromLocation(location))
    }
    
    fileprivate func detailTextFromLocation(_ location: Location) -> String {
        if location.region.isEmpty {
            return location.country
        }
        
        return "\(location.region), \(location.country)"
    }
}
