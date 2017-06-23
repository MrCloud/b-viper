import Foundation
import Swinject
import LocationClient

class WeatherListDefaultRouter: WeatherListRouter {
    
    weak var viewController: UIViewController?
    
    init (viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func navigateToWeatherDetail(withLocation location: Location) {
        if let weatherDetailVC = self.weatherDetailBuilder()?.buildWeatherDetailModule(withLocation: location) {
            self.viewController?.navigationController?.pushViewController(weatherDetailVC, animated: true)
        }
    }
    
    func navigateToAddLocation() {
        if let LocationVC = self.locationBuilder()?.buildLocationModule() {
            let navController = UINavigationController(rootViewController: LocationVC)
            self.viewController?.present(navController, animated: true, completion: nil)
        }
    }
    
    fileprivate func weatherDetailBuilder() -> WeatherDetailBuilder? {
        return Container.sharedContainer.resolve(WeatherDetailBuilder.self)
    }
    
    fileprivate func locationBuilder() -> LocationBuilder? {
        return Container.sharedContainer.resolve(LocationBuilder.self)
    }
    
}
