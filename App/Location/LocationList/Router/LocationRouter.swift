import UIKit

protocol LocationRouter {
    
    func navigateBack()
    
}

class LocationModalRouter: LocationRouter {
    
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    // MARK: <LocationRouter>
    
    func navigateBack() {
        self.viewController?.dismiss(animated: true, completion: nil)
    }
}
