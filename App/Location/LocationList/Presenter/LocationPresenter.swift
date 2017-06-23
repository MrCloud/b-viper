import Foundation
import LocationClient


/// The presenter for weather location module
public protocol LocationPresenter {
    func loadContent()
    func searchLocation(_ text: String)
    func selectLocation(_ locationId: String)
    func cancelSearchForLocation()
}

class LocationDefaultPresenter: LocationPresenter {
    
    fileprivate weak var view: LocationView?
    fileprivate let interactor: LocationInteractor
    fileprivate let router: LocationRouter
    
    fileprivate var locations: [Location]?
    fileprivate let viewModelBuilder = SelectableLocationListViewModelBuilder()
    
    init(view: LocationView, interactor: LocationInteractor, router: LocationRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: <LocationPresenter>
    
    func loadContent() {
        self.view?.displaySearch()
    }
    
    func searchLocation(_ text: String) {
        if text.characters.isEmpty {
            return
        }
        self.view?.displayLoading()
        self.interactor.findLocation(text, completion: { (result) in
            switch result {
            case .success(let locations):
                if !locations.isEmpty {
                    self.locations = locations
                    let viewModel = self.viewModelBuilder.buildViewModel(locations)
                    self.view?.displayLocations(viewModel)
                } else {
                    self.view?.displayNoResults()
                }
            case .failure(let error):
                self.view?.displayErrorMessage(error.localizedDescription)
            }
        })
    }
    
    func selectLocation(_ locationId: String) {
        if let locations = self.locations, let index = locations.index(where: { $0.locationId == locationId }) {
            let selectedLocation = locations[index]
            self.interactor.selectLocation(selectedLocation)
        }
        
        self.router.navigateBack()
    }
    
    func cancelSearchForLocation() {
        self.router.navigateBack()
    }
        
}
