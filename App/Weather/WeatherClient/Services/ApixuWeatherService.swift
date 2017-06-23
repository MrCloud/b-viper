import Foundation
import Alamofire


open class ApixuWeatherService: WeatherService {
    
    fileprivate let apixuCitiesUrl = "https://api.apixu.com/v1/forecast.json"
    fileprivate let apixuKey = "6dbb6fcfa4b74a599f580222160508"
    
    // MARK: <CitiesService>
    
    public init() {
    }
    
    public func fetchWeather(forLocationName name: String, completion: @escaping FetchWeatherCompletion) {
        let parameters: [String: Any] = ["key": self.apixuKey, "q": name]
        self.makeRequest(withParameters: parameters, completion: completion)
    }
    
    fileprivate func makeRequest(withParameters parameters: [String: Any]?, completion: @escaping FetchWeatherCompletion) {
        
        Alamofire.request(self.apixuCitiesUrl, method: .get, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success(let JSON):
                if let JSON = JSON as? NSDictionary {
                    let weather = Weather.from(JSON)
                    completion(weather, nil)
                }
            case .failure(let error):
                completion(nil, error)
            }

        }
    }
    
}
