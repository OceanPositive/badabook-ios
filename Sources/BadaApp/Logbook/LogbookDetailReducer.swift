//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain

struct LogbookDetailReducer: Reducer {
    enum Action: Sendable {
        case load(DiveLogID)
        case save
        case delete
        case dismiss
        case setDiveLog(DiveLog)
        case setLogNumber(Int?)
        case setLogDate(Date)
        case setDiveSite(DiveSite?)
        case setDiveSiteSearchResult(LocalSearchResult)
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
        case setNotesInitialized
        case setIsDiveSiteSearchSheetPresenting(Bool)
        case none
    }

    struct State: Sendable, Equatable {
        var origin: DiveLog?
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
        var notesInitialized: Bool = false
        var shouldDismiss: Bool = false
    }

    @UseCase private var getDiveLogUseCase: GetDiveLogUseCase
    @UseCase private var putDiveLogUseCase: PutDiveLogUseCase
    @UseCase private var deleteDiveLogUseCase: DeleteDiveLogUseCase

    func reduce(state: inout State, action: Action) -> AnyEffect<Action> {
        switch action {
        case let .load(diveLogID):
            return .single {
                await executeGetDiveLogUseCase(id: diveLogID)
            }
        case .save:
            return .single { [state] in
                await executePutDiveLogUseCase(state: state)
            }
        case .delete:
            return .concat {
                AnyEffect.single { [state] in
                    await executeDeleteDiveLogUseCase(state: state)
                }
                AnyEffect.just(.dismiss)
            }
        case .dismiss:
            state.shouldDismiss = true
            return .none
        case let .setDiveLog(diveLog):
            state.origin = diveLog
            return setDiveLog(diveLog)
        case let .setLogNumber(logNumber):
            state.logNumber = logNumber
            return .none
        case let .setLogDate(logDate):
            state.logDate = logDate
            return .none
        case let .setDiveSite(diveSite):
            state.diveSite = diveSite
            return .none
        case let .setDiveSiteSearchResult(searchResult):
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
        case .setNotesInitialized:
            state.notesInitialized = true
            return .none
        case let .setIsDiveSiteSearchSheetPresenting(isDiveSiteSearchSheetPresenting):
            state.isDiveSiteSearchSheetPresenting = isDiveSiteSearchSheetPresenting
            return .none
        case .none:
            return .none
        }
    }

    private func setDiveLog(_ diveLog: DiveLog) -> AnyEffect<Action> {
        AnyEffect.merge {
            AnyEffect.just(.setLogNumber(diveLog.logNumber))
            AnyEffect.just(.setLogDate(diveLog.logDate))
            AnyEffect.just(.setDiveSite(diveLog.diveSite))
            if let diveCenter = diveLog.diveCenter {
                AnyEffect.just(.setDiveCenter(diveCenter))
            }
            if let diveStyle = diveLog.diveStyle {
                AnyEffect.just(.setDiveStyle(diveStyle))
            }
            if let entryTime = diveLog.entryTime {
                AnyEffect.just(.setEntryTime(entryTime))
            }
            if let exitTime = diveLog.exitTime {
                AnyEffect.just(.setExitTime(exitTime))
            }
            AnyEffect.just(.setSurfaceInterval(diveLog.surfaceInterval?.rawValue))
            AnyEffect.just(.setEntryAir(diveLog.entryAir?.rawValue))
            AnyEffect.just(.setExitAir(diveLog.exitAir?.rawValue))
            AnyEffect.just(.setMaximumDepth(diveLog.maximumDepth?.rawValue))
            AnyEffect.just(.setAverageDepth(diveLog.averageDepth?.rawValue))
            AnyEffect.just(.setAirTemperature(diveLog.airTemperature?.rawValue))
            AnyEffect.just(.setSurfaceTemperature(diveLog.surfaceTemperature?.rawValue))
            AnyEffect.just(.setBottomTemperature(diveLog.bottomTemperature?.rawValue))
            if let weather = diveLog.weather {
                AnyEffect.just(.setWeather(weather))
            }
            if let feeling = diveLog.feeling {
                AnyEffect.just(.setFeeling(feeling))
            }
            if let notes = diveLog.notes {
                AnyEffect.concat {
                    AnyEffect.just(.setNotes(notes))
                    AnyEffect.just(.setNotesInitialized)
                }
            }
        }
    }

    private func executeGetDiveLogUseCase(id: DiveLogID) async -> Action {
        let result = await getDiveLogUseCase.execute(id: id)
        switch result {
        case let .success(diveLog):
            return .setDiveLog(diveLog)
        case .failure:
            return .none
        }
    }

    private func executePutDiveLogUseCase(state: State) async -> Action {
        guard let diveLog = state.origin else { return .none }
        guard let logNumber = state.logNumber else { return .none }
        let request = DiveLogUpdateRequest(
            identifier: diveLog.identifier,
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
            notes: state.notes,
            insertDate: diveLog.insertDate
        )
        let result = await putDiveLogUseCase.execute(for: request)
        switch result {
        case .success:
            return .dismiss
        case .failure:
            return .none
        }
    }

    private func executeDeleteDiveLogUseCase(state: State) async -> Action {
        guard let identifier = state.origin?.identifier else { return .none }
        let result = await deleteDiveLogUseCase.execute(id: identifier)
        switch result {
        case .success:
            return .dismiss
        case .failure:
            return .none
        }
    }
}

extension LogbookDetailReducer.State {
    var saveButtonDisabled: Bool {
        logNumber == nil
    }
}
