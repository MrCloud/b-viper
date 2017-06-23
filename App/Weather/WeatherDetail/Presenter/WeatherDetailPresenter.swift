import Foundation
import WeatherClient


protocol WeatherDetailPresenter: class {
    func loadContent()
}

class WeatherDetailDefaultPresenter: WeatherDetailPresenter {
    
    let interactor: WeatherDetailInteractor
    weak var view: WeatherDetailView?
    fileprivate let viewModelBuilder = WeatherDetailViewModelBuilder()

    required init(interactor: WeatherDetailInteractor, view: WeatherDetailView) {
        self.interactor = interactor
        self.view = view
    }
    
    // MARK: - WeatherDetailPresenter
    
    func loadContent() {
        self.view?.displayLoading()
        self.interactor.fetchWeather {(result) in
            switch result {
            case .success(let weather):
                let vm = self.viewModelBuilder.buildViewModel(weather)
                self.view?.displayWeatherDetail(vm)
                break
            case .failure(let reason):
                self.view?.displayError(reason.localizedDescription)
            }
        }
    }
}
