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
    var diveCenter: String?
    var diveStyle: DiveStyle?
    var entryTime: Date?
    var exitTime: Date?
    var surfaceInterval: UnitValue.Time?
    var entryAir: UnitValue.Pressure?
    var exitAir: UnitValue.Pressure?
    var gasType: DiveGasType?
    var equipment: Equipment?
    var maximumDepth: UnitValue.Distance?
    var averageDepth: UnitValue.Distance?
    var airTemperature: UnitValue.Temperature?
    var surfaceTemperature: UnitValue.Temperature?
    var bottomTemperature: UnitValue.Temperature?
    var weather: Weather?
    var surge: Surge?
    var visibility: Visibility?
    var visibilityDistance: UnitValue.Distance?
    var feeling: Feeling?
    var companions: [Companion]
    var notes: String?
    var insertDate: Date
    var updateDate: Date

    init(
        id: UUID,
        logNumber: Int,
        logDate: Date? = nil,
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
        insertDate: Date,
        updateDate: Date
    ) {
        self.id = id
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
            diveCenter: diveCenter,
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
            airTemperature: airTemperature,
            surfaceTemperature: surfaceTemperature,
            bottomTemperature: bottomTemperature,
            weather: weather?.domain,
            surge: surge?.domain,
            visibility: visibility?.domain,
            visibilityDistance: visibilityDistance,
            feeling: feeling?.domain,
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
            diveCenter: domain.diveCenter,
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
            airTemperature: domain.airTemperature,
            surfaceTemperature: domain.surfaceTemperature,
            bottomTemperature: domain.bottomTemperature,
            weather: domain.weather.map { Weather(domain: $0) },
            surge: domain.surge.map { Surge(domain: $0) },
            visibility: domain.visibility.map { Visibility(domain: $0) },
            visibilityDistance: domain.visibilityDistance,
            feeling: domain.feeling.map { Feeling(domain: $0) },
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
            airTemperature: insertRequest.airTemperature,
            surfaceTemperature: insertRequest.surfaceTemperature,
            bottomTemperature: insertRequest.bottomTemperature,
            weather: insertRequest.weather.map { Weather(domain: $0) },
            surge: insertRequest.surge.map { Surge(domain: $0) },
            visibility: insertRequest.visibility.map { Visibility(domain: $0) },
            visibilityDistance: insertRequest.visibilityDistance,
            feeling: insertRequest.feeling.map { Feeling(domain: $0) },
            companions: insertRequest.companions.map { Companion(domain: $0) },
            notes: insertRequest.notes,
            insertDate: Date.now,
            updateDate: Date.now
        )
    }
}
