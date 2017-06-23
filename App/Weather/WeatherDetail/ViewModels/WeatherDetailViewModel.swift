//
//  WeatherDetailViewModel.swift
//  Weather
//
//  Created by Florian PETIT on 23/06/2017.
//  Copyright © 2017 MTT. All rights reserved.
//

import UIKit

struct WeatherDetailViewModel {
    let cityName: String
    let temperature: String
    let forecasts: [WeatherDetailForecastViewModel]
}
