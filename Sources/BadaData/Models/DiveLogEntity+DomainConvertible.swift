import Foundation
import BadaDomain

extension DiveLogEntity: DomainConvertible {
    var domain: DiveLog {
        DiveLog(
            location: location.domain,
            entryTime: entryTime,
            exitTime: exitTime,
            depth: depth,
            duration: duration,
            waterTemperature: waterTemperature,
            visibility: visibility,
            airConsumption: airConsumption,
            diveBuddy: diveBuddy,
            diveType: diveType,
            notes: notes
        )
    }

    convenience init(domain: DiveLog) {
        self.init(
            location: Location(domain: domain.location),
            entryTime: domain.entryTime,
            exitTime: domain.exitTime,
            depth: domain.depth,
            duration: domain.duration,
            waterTemperature: domain.waterTemperature,
            visibility: domain.visibility,
            airConsumption: domain.airConsumption,
            diveBuddy: domain.diveBuddy,
            diveType: domain.diveType,
            notes: domain.notes
        )
    }
}

extension DiveLogEntity.Location: DomainConvertible {
    var domain: DiveLog.Location {
        DiveLog.Location(
            latitude: latitude,
            longitude: longitude,
            siteName: siteName,
            country: country
        )
    }

    init(domain: DiveLog.Location) {
        self.latitude = domain.latitude
        self.longitude = domain.longitude
        self.siteName = domain.siteName
        self.country = domain.country
    }
}
