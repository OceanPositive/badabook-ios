//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import Foundation
import SwiftData

@Model
final class DiveLogEntity {
    var location: Location
    var entryTime: Date
    var exitTime: Date
    var depth: Double
    var duration: TimeInterval
    var waterTemperature: Double?
    var visibility: Double?
    var airConsumption: Double?
    var diveBuddy: String?
    var diveType: String
    var notes: String?

    init(
        location: Location,
        entryTime: Date,
        exitTime: Date,
        depth: Double,
        duration: TimeInterval,
        waterTemperature: Double? = nil,
        visibility: Double? = nil,
        airConsumption: Double? = nil,
        diveBuddy: String? = nil,
        diveType: String,
        notes: String? = nil
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

extension DiveLogEntity {
    struct Location: Codable {
        let latitude: Double
        let longitude: Double
        let siteName: String
        let country: String
    }
}
