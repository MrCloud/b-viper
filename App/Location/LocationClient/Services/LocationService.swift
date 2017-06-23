import Foundation

public typealias LocationServiceCompletion = (_ locations: [Location]?, _ error: Error?) -> Void

/// Service in charge of retrieving city information based on search term
public protocol LocationService {
    
    /// Fetches cities based on a search string
    ///
    /// - parameter name:       search string
    /// - parameter completion: list of matching cities or error
    func fetchLocations(withName name: String, completion: @escaping LocationServiceCompletion)
}
