//
//  WeatherDetailViewModelBuilder.swift
//  Weather
//
//  Created by Florian PETIT on 23/06/2017.
//  Copyright © 2017 MTT. All rights reserved.
//

import Foundation
import WeatherClient

struct WeatherDetailViewModelBuilder {
    
    func buildViewModel(_ data: Weather) -> WeatherDetailViewModel {
        var forecasts = [WeatherDetailForecastViewModel]()
        
        let df = DateFormatter()
        df.dateFormat = "EEEE"
        var date = Date()
        
        for temp in data.forecastInDays {
            let day = df.string(from: date)
            
            let forecast = WeatherDetailForecastViewModel(day: day, temp: temp + data.temperatureUnit)
            forecasts.append(forecast)
            
            date = date.addingTimeInterval(24 * 60 * 60)
        }
        
        return WeatherDetailViewModel(cityName: data.locationName,
                                      temperature: data.temperature + data.temperatureUnit,
                                      forecasts: forecasts)
    }
    
}
