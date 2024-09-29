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
    @Attribute(.unique)
    var id: UUID
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
    var insertDate: Date
    var updateDate: Date

    init(
        id: UUID,
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
        notes: String? = nil,
        insertDate: Date,
        updateDate: Date
    ) {
        self.id = id
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
        self.insertDate = insertDate
        self.updateDate = updateDate
    }
}

extension DiveLogEntity: DomainConvertible {
    var domain: BadaDomain.DiveLog {
        BadaDomain.DiveLog(
            id: id,
            logNumber: logNumber,
            logDate: logDate,
            diveSite: diveSite?.domain,
            diveStyle: diveStyle?.domain,
            entryTime: entryTime,
            exitTime: exitTime,
            surfaceInterval: surfaceInterval,
            entryAir: entryAir,
            exitAir: exitAir,
            gasType: gasType?.domain,
            equipment: equipment?.domain,
            maximumDepth: maximumDepth,
            averageDepth: averageDepth,
            maximumWaterTemperature: maximumWaterTemperature,
            minimumWaterTemperature: minimumWaterTemperature,
            averageWaterTemperature: averageWaterTemperature,
            weather: weather?.domain,
            visibility: visibility?.domain,
            visibilityDistance: visibilityDistance,
            companions: companions.map { $0.domain },
            notes: notes,
            insertDate: insertDate,
            updateDate: updateDate
        )
    }

    convenience init(domain: BadaDomain.DiveLog) {
        self.init(
            id: domain.id,
            logNumber: domain.logNumber,
            logDate: domain.logDate,
            diveSite: domain.diveSite.map { DiveSite(domain: $0) },
            diveStyle: domain.diveStyle.map { DiveStyle(domain: $0) },
            entryTime: domain.entryTime,
            exitTime: domain.exitTime,
            surfaceInterval: domain.surfaceInterval,
            entryAir: domain.entryAir,
            exitAir: domain.exitAir,
            gasType: domain.gasType.map { DiveGasType(domain: $0) },
            equipment: domain.equipment.map { Equipment(domain: $0) },
            maximumDepth: domain.maximumDepth,
            averageDepth: domain.averageDepth,
            maximumWaterTemperature: domain.maximumWaterTemperature,
            minimumWaterTemperature: domain.minimumWaterTemperature,
            averageWaterTemperature: domain.averageWaterTemperature,
            weather: domain.weather.map { Weather(domain: $0) },
            visibility: domain.visibility.map { Visibility(domain: $0) },
            visibilityDistance: domain.visibilityDistance,
            companions: domain.companions.map { Companion(domain: $0) },
            notes: domain.notes,
            insertDate: domain.insertDate,
            updateDate: domain.updateDate
        )
    }
}

extension DiveLogEntity {
    convenience init(insertRequest: BadaDomain.DiveLogInsertRequest) {
        self.init(
            id: UUID(),
            logNumber: insertRequest.logNumber,
            logDate: insertRequest.logDate,
            diveSite: insertRequest.diveSite.map { DiveSite(domain: $0) },
            diveStyle: insertRequest.diveStyle.map { DiveStyle(domain: $0) },
            entryTime: insertRequest.entryTime,
            exitTime: insertRequest.exitTime,
            surfaceInterval: insertRequest.surfaceInterval,
            entryAir: insertRequest.entryAir,
            exitAir: insertRequest.exitAir,
            gasType: insertRequest.gasType.map { DiveGasType(domain: $0) },
            equipment: insertRequest.equipment.map { Equipment(domain: $0) },
            maximumDepth: insertRequest.maximumDepth,
            averageDepth: insertRequest.averageDepth,
            maximumWaterTemperature: insertRequest.maximumWaterTemperature,
            minimumWaterTemperature: insertRequest.minimumWaterTemperature,
            averageWaterTemperature: insertRequest.averageWaterTemperature,
            weather: insertRequest.weather.map { Weather(domain: $0) },
            visibility: insertRequest.visibility.map { Visibility(domain: $0) },
            visibilityDistance: insertRequest.visibilityDistance,
            companions: insertRequest.companions.map { Companion(domain: $0) },
            notes: insertRequest.notes,
            insertDate: Date.now,
            updateDate: Date.now
        )
    }
}
