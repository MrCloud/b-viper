import Foundation

public typealias FetchWeatherCompletion = (_ weather: Weather?, _ error: Error?) -> Void

public protocol WeatherService {
    func fetchWeather(forLocationName name: String, completion: @escaping FetchWeatherCompletion)
}
