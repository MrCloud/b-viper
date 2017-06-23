import Foundation
import Alamofire
import Mapper

open class ApixuLocationService: LocationService {
    
    fileprivate let apixuCitiesUrl = "https://api.apixu.com/v1/search.json"
    fileprivate let apixuKey = "6dbb6fcfa4b74a599f580222160508"
    
    public init() {
    }
    
    // MARK: <CitiesService>
    
    open func fetchLocations(withName name: String, completion: @escaping LocationServiceCompletion) {
        let parameters = ["key": self.apixuKey,
                          "q": name]
        
        Alamofire.request(self.apixuCitiesUrl, method: .get, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success(let JSON):
                if let JSON = JSON as? NSArray {
                    let cities = Location.from(JSON)
                    completion(cities, nil)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
}
