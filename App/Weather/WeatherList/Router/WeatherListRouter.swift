import Foundation
import LocationClient

protocol WeatherListRouter {
    func navigateToWeatherDetail(withLocation location: Location)
    func navigateToAddLocation()
}
