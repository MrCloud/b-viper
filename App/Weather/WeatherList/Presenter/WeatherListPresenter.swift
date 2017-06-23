import Foundation
import LocationClient

protocol WeatherListPresenter {
    func loadContent()
    func presentWeatherDetail(_ location: String)
    func presentAddLocation()
}

class WeatherListDefaultPresenter: WeatherListPresenter {
    
    fileprivate let interactor: WeatherListInteractor
    fileprivate let router: WeatherListRouter
    fileprivate weak var view: WeatherListView?
    fileprivate let viewModelBuilder = LocationListViewModelBuilder()
    
    required init(interactor: WeatherListInteractor, router: WeatherListRouter, view: WeatherListView) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }
    
    // MARK: <WeatherListPresenter>
    
    func loadContent() {
        let locations = self.interactor.locations()
        self.view?.displayLocationList(self.viewModelBuilder.buildViewModel(locations))
    }
    
    func presentWeatherDetail(_ locationId: String) {
        let index = self.interactor.locations().index(where: {$0.locationId == locationId})
        if let index = index {
            self.router.navigateToWeatherDetail(withLocation: self.interactor.locations()[index])
        }
        
    }
    
    func presentAddLocation() {
        self.router.navigateToAddLocation()
    }
    
}
