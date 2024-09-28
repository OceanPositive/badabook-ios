//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain
import SwiftData

@Model
final class DiveLogEntity {
    var logNumber: Int
    var logDate: Date?
    var diveSite: DiveSite?
    var diveStyle: DiveStyle?
    var entryTime: Date?
    var exitTime: Date?
    var surfaceInterval: Double?
    var entryAir: UnitValue.Pressure?
    var exitAir: UnitValue.Pressure?
    var gasType: DiveGasType?
    var equipment: Equipment?
    var maximumDepth: UnitValue.Distance?
    var averageDepth: UnitValue.Distance?
    var maximumWaterTemperature: UnitValue.Temperature?
    var minimumWaterTemperature: UnitValue.Temperature?
    var averageWaterTemperature: UnitValue.Temperature?
    var weather: Weather?
    var visibility: Visibility?
    var visibilityDistance: UnitValue.Distance?
    var companions: [Companion]
    var notes: String?

    init(
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

extension DiveLogEntity: DomainConvertible {
    var domain: BadaDomain.DiveLog {
        BadaDomain.DiveLog(
            logNumber: logNumber,
            logDate: logDate,
            diveSite: diveSite?.domain,
            diveStyle: diveStyle?.domain,
            entryTime: entryTime,
            exitTime: exitTime,
            surfaceInterval: surfaceInterval,
            entryAir: entryAir?.domain,
            exitAir: exitAir?.domain,
            gasType: gasType?.domain,
            equipment: equipment?.domain,
            maximumDepth: maximumDepth?.domain,
            averageDepth: averageDepth?.domain,
            maximumWaterTemperature: maximumWaterTemperature?.domain,
            minimumWaterTemperature: minimumWaterTemperature?.domain,
            averageWaterTemperature: averageWaterTemperature?.domain,
            weather: weather?.domain,
            visibility: visibility?.domain,
            visibilityDistance: visibilityDistance?.domain,
            companions: companions.map { $0.domain },
            notes: notes
        )
    }

    convenience init(domain: BadaDomain.DiveLog) {
        self.init(
            logNumber: domain.logNumber,
            logDate: domain.logDate,
            diveSite: domain.diveSite.map { DiveSite(domain: $0) },
            diveStyle: domain.diveStyle.map { DiveStyle(domain: $0) },
            entryTime: domain.entryTime,
            exitTime: domain.exitTime,
            surfaceInterval: domain.surfaceInterval,
            entryAir: domain.entryAir.map { UnitValue.Pressure(domain: $0) },
            exitAir: domain.exitAir.map { UnitValue.Pressure(domain: $0) },
            gasType: domain.gasType.map { DiveGasType(domain: $0) },
            equipment: domain.equipment.map { Equipment(domain: $0) },
            maximumDepth: domain.maximumDepth.map { UnitValue.Distance(domain: $0) },
            averageDepth: domain.averageDepth.map { UnitValue.Distance(domain: $0) },
            maximumWaterTemperature: domain.maximumWaterTemperature.map { UnitValue.Temperature(domain: $0) },
            minimumWaterTemperature: domain.minimumWaterTemperature.map { UnitValue.Temperature(domain: $0) },
            averageWaterTemperature: domain.averageWaterTemperature.map { UnitValue.Temperature(domain: $0) },
            weather: domain.weather.map { Weather(domain: $0) },
            visibility: domain.visibility.map { Visibility(domain: $0) },
            visibilityDistance: domain.visibilityDistance.map { UnitValue.Distance(domain: $0) },
            companions: domain.companions.map { Companion(domain: $0) },
            notes: domain.notes
        )
    }
}
