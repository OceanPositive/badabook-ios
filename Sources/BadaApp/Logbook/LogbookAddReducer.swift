//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain

struct LogbookAddReducer: Reducer {
    enum Action: Sendable {
        case setLogNumber(Int?)
        case setLogDate(Date)
        case setDiveStyle(DiveStyle)
        case setEntryTime(Date)
        case setExitTime(Date)
        case setSurfaceInterval(Double?)
        case setEntryAir(Double?)
        case setExitAir(Double?)
        case setMaximumDepth(Double?)
        case setAverageDepth(Double?)
        case setMaximumWaterTemperature(Double?)
        case setMinimumWaterTemperature(Double?)
        case setAverageWaterTemperature(Double?)
        case setNotes(String)
    }

    struct State: Sendable, Equatable {
        var logNumber: Int?
        var logDate: Date = Date(timeIntervalSince1970: 0)
        var diveStyle: DiveStyle = .boat
        var entryTime: Date = Date(timeIntervalSince1970: 0)
        var exitTime: Date = Date(timeIntervalSince1970: 0)
        var surfaceInterval: UnitValue.Time?
        var entryAir: UnitValue.Pressure?
        var exitAir: UnitValue.Pressure?
        var maximumDepth: UnitValue.Distance?
        var averageDepth: UnitValue.Distance?
        var maximumWaterTemperature: UnitValue.Temperature?
        var minimumWaterTemperature: UnitValue.Temperature?
        var averageWaterTemperature: UnitValue.Temperature?
        var notes: String = ""
    }

    func reduce(state: inout State, action: Action) -> AnyEffect<Action> {
        switch action {
        case let .setLogNumber(logNumber):
            state.logNumber = logNumber
            return .none
        case let .setLogDate(logDate):
            state.logDate = logDate
            return .none
        case let .setDiveStyle(diveStyle):
            state.diveStyle = diveStyle
            return .none
        case let .setEntryTime(entryTime):
            state.entryTime = entryTime
            return .none
        case let .setExitTime(exitTime):
            state.exitTime = exitTime
            return .none
        case let .setSurfaceInterval(surfaceInterval):
            if let surfaceInterval {
                state.surfaceInterval = .minute(surfaceInterval)
            } else {
                state.surfaceInterval = nil
            }
            return .none
        case let .setEntryAir(entryAir):
            if let entryAir {
                state.entryAir = .bar(entryAir)
            } else {
                state.entryAir = nil
            }
            return .none
        case let .setExitAir(exitAir):
            if let exitAir {
                state.exitAir = .bar(exitAir)
            } else {
                state.exitAir = nil
            }
            return .none
        case let .setMaximumDepth(maximumDepth):
            if let maximumDepth {
                state.maximumDepth = .m(maximumDepth)
            } else {
                state.maximumDepth = nil
            }
            return .none
        case let .setAverageDepth(averageDepth):
            if let averageDepth {
                state.averageDepth = .m(averageDepth)
            } else {
                state.averageDepth = nil
            }
            return .none
        case let .setMaximumWaterTemperature(maximumWaterTemperature):
            if let maximumWaterTemperature {
                state.maximumWaterTemperature = .celsius(maximumWaterTemperature)
            } else {
                state.maximumWaterTemperature = nil
            }
            return .none
        case let .setMinimumWaterTemperature(minimumWaterTemperature):
            if let minimumWaterTemperature {
                state.minimumWaterTemperature = .celsius(minimumWaterTemperature)
            } else {
                state.minimumWaterTemperature = nil
            }
            return .none
        case let .setAverageWaterTemperature(averageWaterTemperature):
            if let averageWaterTemperature {
                state.averageWaterTemperature = .celsius(averageWaterTemperature)
            } else {
                state.averageWaterTemperature = nil
            }
            return .none
        case let .setNotes(notes):
            state.notes = notes
            return .none
        }
    }
}
