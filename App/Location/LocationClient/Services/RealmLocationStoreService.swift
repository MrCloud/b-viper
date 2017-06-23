import Foundation
import RealmSwift

open class RealmLocationStoreService: LocationStoreService {

    fileprivate let realm: Realm?

    public init() {
        do {
            self.realm = try Realm()
        } catch let error {
            self.realm = nil
            print(error)
        }
    }

    // MARK: <CityStoreService>

    open func addLocation(_ location: Location) {
        let realmCity = self.realmLocation(fromLocation: location)

        do {
            try self.realm?.write {
                self.realm?.add(realmCity)
            }
        } catch let error {
            print(error)
        }
    }

    open func locations() -> [Location] {
        if let realm = self.realm {
            return realm.objects(RealmLocation.self).map({ (realmLocation) -> Location in
                return self.location(fromRealmLocation: realmLocation)
            })
        } else {
            return [Location]()
        }
    }

    open func deleteLocations() {
        if let locations = self.realm?.objects(RealmLocation.self) {
            self.realm?.delete(locations)
        }
    }

    // MARK: Private

    fileprivate func realmLocation(fromLocation location: Location) -> RealmLocation {
        let realmLocation = RealmLocation()

        realmLocation.locationId = location.locationId
        realmLocation.name = location.name
        realmLocation.region = location.region
        realmLocation.country = location.country

        if let latitude = location.latitude, let longitude = location.longitude {
            realmLocation.latitude.value = latitude
            realmLocation.longitude.value = longitude
        }

        return realmLocation
    }

    fileprivate func location(fromRealmLocation realmLocation: RealmLocation) -> Location {
        let location = Location(locationId: realmLocation.locationId,
                name: realmLocation.name,
                region: realmLocation.region,
                country: realmLocation.country,
                latitude: realmLocation.latitude.value,
                longitude: realmLocation.longitude.value)

        return location
    }

}
