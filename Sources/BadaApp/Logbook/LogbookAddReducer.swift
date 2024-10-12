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
        case setBottomTime(Double?)
        case setSurfaceInterval(Double?)
        case setEntryAir(Double?)
        case setExitAir(Double?)
        case setMaximumDepth(Double?)
        case setAverageDepth(Double?)
        case setAirTemperature(Double?)
        case setSurfaceTemperature(Double?)
        case setBottomTemperature(Double?)
        case setNotes(String)
    }

    struct State: Sendable, Equatable {
        var logNumber: Int?
        var logDate: Date = Date(timeIntervalSince1970: 0)
        var diveStyle: DiveStyle = .boat
        var entryTime: Date = Date(timeIntervalSince1970: 0)
        var exitTime: Date = Date(timeIntervalSince1970: 0)
        var bottomTime: UnitValue.Time?
        var surfaceInterval: UnitValue.Time?
        var entryAir: UnitValue.Pressure?
        var exitAir: UnitValue.Pressure?
        var maximumDepth: UnitValue.Distance?
        var averageDepth: UnitValue.Distance?
        var airTemperature: UnitValue.Temperature?
        var surfaceTemperature: UnitValue.Temperature?
        var bottomTemperature: UnitValue.Temperature?
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
        case let .setBottomTime(bottomTime):
            if let bottomTime {
                state.bottomTime = .minute(bottomTime)
            } else {
                state.bottomTime = nil
            }
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
        case let .setAirTemperature(airTemperature):
            if let airTemperature {
                state.airTemperature = .celsius(airTemperature)
            } else {
                state.airTemperature = nil
            }
            return .none
        case let .setSurfaceTemperature(surfaceTemperature):
            if let surfaceTemperature {
                state.surfaceTemperature = .celsius(surfaceTemperature)
            } else {
                state.surfaceTemperature = nil
            }
            return .none
        case let .setBottomTemperature(bottomTemperature):
            if let bottomTemperature {
                state.bottomTemperature = .celsius(bottomTemperature)
            } else {
                state.bottomTemperature = nil
            }
            return .none
        case let .setNotes(notes):
            state.notes = notes
            return .none
        }
    }
}
