//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore

package struct DiveLog: Equatable {
    package let logNumber: Int
    package let logDate: Date?
    package let diveSite: DiveSite?
    package let diveStyle: DiveStyle?
    package let entryTime: Date?
    package let exitTime: Date?
    package let surfaceInterval: Double?
    package let entryAir: UnitValue.Pressure?
    package let exitAir: UnitValue.Pressure?
    package let gasType: DiveGasType?
    package let equipment: Equipment?
    package let maximumDepth: UnitValue.Distance?
    package let averageDepth: UnitValue.Distance?
    package let maximumWaterTemperature: UnitValue.Temperature?
    package let minimumWaterTemperature: UnitValue.Temperature?
    package let averageWaterTemperature: UnitValue.Temperature?
    package let weather: Weather?
    package let visibility: Visibility?
    package let visibilityDistance: UnitValue.Distance?
    package let companions: [Companion]
    package let notes: String?

    package init(
        logNumber: Int,
        logDate: Date? = nil,
        diveSite: DiveSite? = nil,
        diveStyle: DiveStyle? = nil,
        entryTime: Date? = nil,
        exitTime: Date? = nil,
        surfaceInterval: Double? = nil,
        entryAir: UnitValue.Pressure? = nil,
        exitAir: UnitValue.Pressure? = nil,
        gasType: DiveGasType? = nil,
        equipment: Equipment? = nil,
        maximumDepth: UnitValue.Distance? = nil,
        averageDepth: UnitValue.Distance? = nil,
        maximumWaterTemperature: UnitValue.Temperature? = nil,
        minimumWaterTemperature: UnitValue.Temperature? = nil,
        averageWaterTemperature: UnitValue.Temperature? = nil,
        weather: Weather? = nil,
        visibility: Visibility? = nil,
        visibilityDistance: UnitValue.Distance? = nil,
        companions: [Companion] = [],
        notes: String? = nil
    ) {
        self.logNumber = logNumber
        self.logDate = logDate
        self.diveSite = diveSite
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
        self.maximumWaterTemperature = maximumWaterTemperature
        self.minimumWaterTemperature = minimumWaterTemperature
        self.averageWaterTemperature = averageWaterTemperature
        self.weather = weather
        self.visibility = visibility
        self.visibilityDistance = visibilityDistance
        self.companions = companions
        self.notes = notes
    }
}
