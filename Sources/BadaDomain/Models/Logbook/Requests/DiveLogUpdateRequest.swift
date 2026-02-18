//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025-2026 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore

package struct DiveLogUpdateRequest: Equatable {
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
    package let equipment: Equipment?
    package let maximumDepth: UnitValue.Distance?
    package let averageDepth: UnitValue.Distance?
    package let surfaceTemperature: UnitValue.Temperature?
    package let bottomTemperature: UnitValue.Temperature?
    package let weather: Weather?
    package let feeling: Feeling?
    package let companions: [Companion]
    package let notes: String?
    package let insertDate: Date

    package init(
        identifier: DiveLogID,
        logNumber: Int,
        logDate: Date,
        diveSite: DiveSite?,
        diveCenter: String?,
        diveStyle: DiveStyle?,
        entryTime: Date?,
        exitTime: Date?,
        surfaceInterval: UnitValue.Time?,
        entryAir: UnitValue.Pressure?,
        exitAir: UnitValue.Pressure?,
        equipment: Equipment?,
        maximumDepth: UnitValue.Distance?,
        averageDepth: UnitValue.Distance?,
        surfaceTemperature: UnitValue.Temperature?,
        bottomTemperature: UnitValue.Temperature?,
        weather: Weather?,
        feeling: Feeling?,
        companions: [Companion],
        notes: String?,
        insertDate: Date
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
        self.equipment = equipment
        self.maximumDepth = maximumDepth
        self.averageDepth = averageDepth
        self.surfaceTemperature = surfaceTemperature
        self.bottomTemperature = bottomTemperature
        self.weather = weather
        self.feeling = feeling
        self.companions = companions
        self.notes = notes
        self.insertDate = insertDate
    }
}
