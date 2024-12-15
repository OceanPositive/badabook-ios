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
        case save
        case none
        case setLogNumber(Int?)
        case setLogDate(Date)
        case setDiveSite(LocalSearchResult)
        case setDiveCenter(String)
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
        case setWeather(Weather)
        case setFeeling(Feeling)
        case setNotes(String)
        case setIsDiveSiteSearchSheetPresenting(Bool)
        case setShouldDismiss(Bool)
    }

    struct State: Sendable, Equatable {
        var logNumber: Int?
        var logDate: Date = Date(timeIntervalSince1970: 0)
        var diveSite: DiveSite?
        var diveCenter: String = ""
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
        var weather: Weather = .sunny
        var feeling: Feeling = .good
        var notes: String = ""
        var isDiveSiteSearchSheetPresenting: Bool = false
        var shouldDismiss: Bool = false
    }

    @UseCase private var postDiveLogsUseCase: PostDiveLogUseCase

    func reduce(state: inout State, action: Action) -> AnyEffect<Action> {
        switch action {
        case .save:
            return .single { [state] in
                await executePostDiveLogUseCase(state: state)
            }
        case .none:
            return .none
        case let .setLogNumber(logNumber):
            state.logNumber = logNumber
            return .none
        case let .setLogDate(logDate):
            state.logDate = logDate
            return .none
        case let .setDiveSite(searchResult):
            if let coordinate = searchResult.coordinate {
                state.diveSite = DiveSite(
                    title: searchResult.title,
                    subtitle: searchResult.subtitle,
                    coordinate: DiveSite.Coordinate(
                        latitude: coordinate.latitude,
                        longitude: coordinate.longitude
                    )
                )
            } else {
                state.diveSite = DiveSite(
                    title: searchResult.title,
                    subtitle: searchResult.subtitle
                )
            }
            return .none
        case let .setDiveCenter(diveCenter):
            state.diveCenter = diveCenter
            return .none
        case let .setDiveStyle(diveStyle):
            state.diveStyle = diveStyle
            return .none
        case let .setEntryTime(entryTime):
            state.entryTime = entryTime
            let interval = state.exitTime.timeIntervalSince(entryTime) / 60
            state.bottomTime = .minute(interval)
            return .none
        case let .setExitTime(exitTime):
            state.exitTime = exitTime
            let interval = exitTime.timeIntervalSince(state.entryTime) / 60
            state.bottomTime = .minute(interval)
            return .none
        case let .setBottomTime(bottomTime):
            if let bottomTime {
                state.bottomTime = .minute(bottomTime)
                state.exitTime = state.entryTime.addingTimeInterval(bottomTime * 60)
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
        case let .setWeather(weather):
            state.weather = weather
            return .none
        case let .setFeeling(feeling):
            state.feeling = feeling
            return .none
        case let .setNotes(notes):
            state.notes = notes
            return .none
        case let .setIsDiveSiteSearchSheetPresenting(isDiveSiteSearchSheetPresenting):
            state.isDiveSiteSearchSheetPresenting = isDiveSiteSearchSheetPresenting
            return .none
        case let .setShouldDismiss(shouldDismiss):
            state.shouldDismiss = shouldDismiss
            return .none
        }
    }

    private func executePostDiveLogUseCase(state: State) async -> Action {
        guard let logNumber = state.logNumber else { return .none }
        let request = DiveLogInsertRequest(
            logNumber: logNumber,
            logDate: state.logDate,
            diveSite: state.diveSite,
            diveCenter: state.diveCenter,
            diveStyle: state.diveStyle,
            entryTime: state.entryTime,
            exitTime: state.exitTime,
            surfaceInterval: state.surfaceInterval,
            entryAir: state.entryAir,
            exitAir: state.exitAir,
            gasType: nil,
            equipment: nil,
            maximumDepth: state.maximumDepth,
            averageDepth: state.averageDepth,
            airTemperature: state.airTemperature,
            surfaceTemperature: state.surfaceTemperature,
            bottomTemperature: state.bottomTemperature,
            weather: state.weather,
            surge: nil,
            visibility: nil,
            visibilityDistance: nil,
            feeling: state.feeling,
            companions: [],
            notes: state.notes
        )
        let result = await postDiveLogsUseCase.execute(for: request)
        switch result {
        case .success:
            return .setShouldDismiss(true)
        case .failure:
            return .none
        }
    }
}

extension LogbookAddReducer.State {
    var saveButtonDisabled: Bool {
        logNumber == nil
    }
}
