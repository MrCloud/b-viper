import Foundation
import UIKit
import LocationClient

protocol WeatherDetailBuilder {
    func buildWeatherDetailModule(withLocation location: Location) -> UIViewController?
}
