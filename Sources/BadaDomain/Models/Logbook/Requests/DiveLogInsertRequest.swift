//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore

package struct DiveLogInsertRequest: Equatable {
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

    package init(
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
        gasType: DiveGasType?,
        equipment: Equipment?,
        maximumDepth: UnitValue.Distance?,
        averageDepth: UnitValue.Distance?,
        airTemperature: UnitValue.Temperature?,
        surfaceTemperature: UnitValue.Temperature?,
        bottomTemperature: UnitValue.Temperature?,
        weather: Weather?,
        surge: Surge?,
        visibility: Visibility?,
        visibilityDistance: UnitValue.Distance?,
        feeling: Feeling?,
        companions: [Companion],
        notes: String?
    ) {
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
        self.weather = weather
        self.surge = surge
        self.visibility = visibility
        self.visibilityDistance = visibilityDistance
        self.feeling = feeling
        self.companions = companions
        self.notes = notes
    }
}
