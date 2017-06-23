import Foundation
import Swinject
import LocationClient

class LocationSwiftInjectBuilder: LocationBuilder {
    
    func buildLocationModule() -> UIViewController? {
        registerView()
        registerInteractor()
        registerPresenter()
        registerRouter()
        
        return Container.sharedContainer.resolve(LocationView.self) as? UIViewController
    }

    // MARK: Private
    
    fileprivate func registerView() {
        let viewDescription = Container.sharedContainer.register(LocationView.self) { _ in LocationViewController()}
        viewDescription.initCompleted { resolver, view in
            if let view = view as? LocationViewController {
                view.presenter = resolver.resolve(LocationPresenter.self)
            }
        }
    
    }
    
    fileprivate func registerInteractor() {
        Container.sharedContainer.register(LocationInteractor.self) { resolver in
            LocationCitiesInteractor(locationService: resolver.resolve(LocationService.self)!,
                                            locationStoreService: resolver.resolve(LocationStoreService.self)!)
        }
    }
    
    fileprivate func registerPresenter() {
        Container.sharedContainer.register(LocationPresenter.self) { resolver in
            LocationDefaultPresenter(view: resolver.resolve(LocationView.self)!,
                                            interactor: resolver.resolve(LocationInteractor.self)!,
                                            router: resolver.resolve(LocationRouter.self)!)
        }
    }
    
    fileprivate func registerRouter() {
        Container.sharedContainer.register(LocationRouter.self) { resolver in
            let viewController = (resolver.resolve(LocationView.self) as? UIViewController)!
            return LocationModalRouter(viewController: viewController)
        }
    }
    
}
