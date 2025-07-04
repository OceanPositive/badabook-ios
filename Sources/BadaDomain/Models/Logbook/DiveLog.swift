//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore

package struct DiveLog: Equatable {
    package let identifier: DiveLogID
    package let logNumber: Int
    package let logDate: Date
    package let diveSite: DiveSite?
    package let diveCenter: String?
    package let diveStyle: DiveStyle?
    package let entryTime: Date?
    package let exitTime: Date?
    package let surfaceInterval: UnitValue.Time?
    package let entryAir: UnitValue.Pressure?
    package let exitAir: UnitValue.Pressure?
    package let gasType: DiveGasType?
    package let equipment: Equipment?
    package let maximumDepth: UnitValue.Distance?
    package let averageDepth: UnitValue.Distance?
    package let airTemperature: UnitValue.Temperature?
    package let surfaceTemperature: UnitValue.Temperature?
    package let bottomTemperature: UnitValue.Temperature?
    package let weather: Weather?
    package let surge: Surge?
    package let visibility: Visibility?
    package let visibilityDistance: UnitValue.Distance?
    package let feeling: Feeling?
    package let companions: [Companion]
    package let notes: String?
    package let insertDate: Date
    package let updateDate: Date

    package init(
        identifier: DiveLogID = DiveLogID(),
        logNumber: Int,
        logDate: Date,
        diveSite: DiveSite? = nil,
        diveCenter: String? = nil,
        diveStyle: DiveStyle? = nil,
        entryTime: Date? = nil,
        exitTime: Date? = nil,
        surfaceInterval: UnitValue.Time? = nil,
        entryAir: UnitValue.Pressure? = nil,
        exitAir: UnitValue.Pressure? = nil,
        gasType: DiveGasType? = nil,
        equipment: Equipment? = nil,
        maximumDepth: UnitValue.Distance? = nil,
        averageDepth: UnitValue.Distance? = nil,
        airTemperature: UnitValue.Temperature? = nil,
        surfaceTemperature: UnitValue.Temperature? = nil,
        bottomTemperature: UnitValue.Temperature? = nil,
        weather: Weather? = nil,
        surge: Surge? = nil,
        visibility: Visibility? = nil,
        visibilityDistance: UnitValue.Distance? = nil,
        feeling: Feeling? = nil,
        companions: [Companion] = [],
        notes: String? = nil,
        insertDate: Date = Date(timeIntervalSince1970: 0),
        updateDate: Date = Date(timeIntervalSince1970: 0)
    ) {
        self.identifier = identifier
        self.logNumber = logNumber
        self.logDate = logDate
        self.diveSite = diveSite
        self.diveCenter = diveCenter
        self.diveStyle = diveStyle
        self.entryTime = entryTime
        self.exitTime = exitTime
        self.surfaceInterval = surfaceInterval
        self.entryAir = entryAir
        self.exitAir = exitAir
        self.gasType = gasType
        self.equipment = equipment
        self.maximumDepth = maximumDepth
        self.averageDepth = averageDepth
        self.airTemperature = airTemperature
        self.surfaceTemperature = surfaceTemperature
        self.bottomTemperature = bottomTemperature
        self.surge = surge
        self.weather = weather
        self.visibility = visibility
        self.visibilityDistance = visibilityDistance
        self.feeling = feeling
        self.companions = companions
        self.notes = notes
        self.insertDate = insertDate
        self.updateDate = updateDate
    }
}
