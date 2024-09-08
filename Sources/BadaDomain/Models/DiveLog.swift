import Foundation

package struct DiveLog: Equatable {
    /// Dive location information
    package let location: Location
    /// Time of entry into the water
    package let entryTime: Date
    /// Time of exit from the water
    package let exitTime: Date
     /// Maximum depth (meters)
    package let depth: Double
     /// Dive duration (in seconds)
    package let duration: TimeInterval
     /// Water temperature (Celsius)
    package let waterTemperature: Double?
     /// Visibility (meters)
    package let visibility: Double?
     /// Air consumption (liters)
    package let airConsumption: Double?
     /// Dive buddy's name
    package let diveBuddy: String?
     /// Type of dive (e.g., recreational, night dive)
    package let diveType: String
     /// Additional notes, optional
    package let notes: String?

    package init(
        location: Location,
        entryTime: Date,
        exitTime: Date,
        depth: Double,
        duration: TimeInterval,
        waterTemperature: Double?,
        visibility: Double?,
        airConsumption: Double?,
        diveBuddy: String?,
        diveType: String,
        notes: String?
    ) {
        self.location = location
        self.entryTime = entryTime
        self.exitTime = exitTime
        self.depth = depth
        self.duration = duration
        self.waterTemperature = waterTemperature
        self.visibility = visibility
        self.airConsumption = airConsumption
        self.diveBuddy = diveBuddy
        self.diveType = diveType
        self.notes = notes
    }
}

extension DiveLog {
    package struct Location: Equatable {
        package let latitude: Double
        package let longitude: Double
        package let siteName: String
        package let country: String

        package init(
            latitude: Double,
            longitude: Double,
            siteName: String,
            country: String
        ) {
            self.latitude = latitude
            self.longitude = longitude
            self.siteName = siteName
            self.country = country
        }
    }
}
