//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025-2026 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain
import BadaTesting

@testable import BadaApp

@Suite
struct LogbookAddReducerTests {
    init() {
        UseCaseContainer.instance.register {
            PostDiveLogUseCase { _ in .success(Void()) }
        }
        UseCaseContainer.instance.register {
            GetLastDiveLogUseCase { .failure(.noResult) }
        }
    }

    @Test
    func load() async {
        let container = UseCaseContainer()
        container.register {
            PostDiveLogUseCase { _ in .success(Void()) }
        }
        container.register {
            GetLastDiveLogUseCase {
                .success(
                    DiveLog(
                        logNumber: 10,
                        logDate: Date(timeIntervalSince1970: 0),
                        diveSite: DiveSite(title: "Balicasag", subtitle: "Bohol"),
                        diveCenter: "Good Diver",
                        diveStyle: .beach,
                        entryAir: .bar(200)
                    )
                )
            }
        }
        await UseCaseContainer.$instance.withValue(container) {
            let sut = Store(
                reducer: LogbookAddReducer(),
                state: LogbookAddReducer.State()
            )
            await sut.send(.load)
            await sut.expect(\.isLoading, false)
            await sut.expect(\.logNumber, 11)
            await sut.expect(\.logDate, Date(timeIntervalSince1970: 0))
            await sut.expect(\.diveSite, DiveSite(title: "Balicasag", subtitle: "Bohol"))
            await sut.expect(\.diveCenter, "Good Diver")
            await sut.expect(\.diveStyle, .beach)
            await sut.expect(\.entryAir, .bar(200))
        }
    }

    @Test
    func add() async {
        let sut = Store(
            reducer: LogbookAddReducer(),
            state: LogbookAddReducer.State(logNumber: 1)
        )
        await sut.send(.add)
        await sut.expect(\.shouldDismiss, true)
    }

    @Test
    func dismiss() async {
        let sut = Store(
            reducer: LogbookAddReducer(),
            state: LogbookAddReducer.State()
        )
        await sut.send(.dismiss)
        await sut.expect(\.shouldDismiss, true)
    }

    @Test
    func setLastDiveLog() async {
        let sut = Store(
            reducer: LogbookAddReducer(),
            state: LogbookAddReducer.State()
        )
        let diveLog = DiveLog(
            logNumber: 10,
            logDate: Date(timeIntervalSince1970: 0),
            diveSite: DiveSite(title: "Balicasag", subtitle: "Bohol"),
            diveCenter: "Good Diver",
            diveStyle: .beach,
            entryAir: .bar(200)
        )
        await sut.send(.setLastDiveLog(diveLog))
        await sut.expect(\.logNumber, 11)
        await sut.expect(\.logDate, Date(timeIntervalSince1970: 0))
        await sut.expect(\.diveSite, DiveSite(title: "Balicasag", subtitle: "Bohol"))
        await sut.expect(\.diveCenter, "Good Diver")
        await sut.expect(\.diveStyle, .beach)
        await sut.expect(\.entryAir, .bar(200))
    }

    @Test
    func setLogNumber() async {
        let sut = Store(
            reducer: LogbookAddReducer(),
            state: LogbookAddReducer.State()
        )
        await sut.expect(\.logNumber, nil)
        await sut.send(.setLogNumber(12))
        await sut.expect(\.logNumber, 12)
    }

    @Test
    func setLogDate() async {
        let sut = Store(
            reducer: LogbookAddReducer(),
            state: LogbookAddReducer.State()
        )
        await sut.send(.setLogDate(Date(timeIntervalSince1970: 12)))
        await sut.expect(\.logDate, Date(timeIntervalSince1970: 12))
    }

    @Test
    func setDiveSite() async {
        let sut = Store(
            reducer: LogbookAddReducer(),
            state: LogbookAddReducer.State()
        )
        await sut.expect(\.diveSite, nil)
        await sut.send(.setDiveSite(DiveSite(title: "Balicasag", subtitle: "Bohol")))
        await sut.expect(\.diveSite?.title, "Balicasag")
        await sut.expect(\.diveSite?.subtitle, "Bohol")
    }

    @Test
    func setDiveSiteBySearching() async {
        let sut = Store(
            reducer: LogbookAddReducer(),
            state: LogbookAddReducer.State()
        )
        await sut.expect(\.diveSite, nil)
        let searchResult = LocalSearchResult(
            title: "Hello",
            subtitle: "World",
            coordinate: LocalSearchResult.Coordinate(latitude: 12, longitude: 13)
        )
        await sut.send(.setDiveSiteBySearching(searchResult))
        await sut.expect(\.diveSite?.title, searchResult.title)
        await sut.expect(\.diveSite?.subtitle, searchResult.subtitle)
        await sut.expect(\.diveSite?.coordinate?.latitude, searchResult.coordinate?.latitude)
        await sut.expect(\.diveSite?.coordinate?.longitude, searchResult.coordinate?.longitude)
    }

    @Test
    func setDiveCenter() async {
        let sut = Store(
            reducer: LogbookAddReducer(),
            state: LogbookAddReducer.State()
        )
        await sut.expect(\.diveCenter, "")
        await sut.send(.setDiveCenter("Hello World"))
        await sut.expect(\.diveCenter, "Hello World")
    }

    @Test
    func setDiveStyle() async {
        let sut = Store(
            reducer: LogbookAddReducer(),
            state: LogbookAddReducer.State()
        )
        await sut.expect(\.diveStyle, .boat)
        await sut.send(.setDiveStyle(.beach))
        await sut.expect(\.diveStyle, .beach)
    }

    @Test
    func setEntryTime() async {
        let sut = Store(
            reducer: LogbookAddReducer(),
            state: LogbookAddReducer.State()
        )
        await sut.expect(\.entryTime, Date(timeIntervalSince1970: 9 * 60 * 60))  // 9:00 AM
        await sut.expect(\.exitTime, Date(timeIntervalSince1970: 9 * 60 * 60))
        await sut.send(.setEntryTime(Date(timeIntervalSince1970: 9 * 60 * 60 + 2 * 60)))
        await sut.expect(\.entryTime, Date(timeIntervalSince1970: 9 * 60 * 60 + 2 * 60))
        await sut.expect(\.bottomTime, .minute(-2))
    }

    @Test
    func setExitTime() async {
        let sut = Store(
            reducer: LogbookAddReducer(),
            state: LogbookAddReducer.State()
        )
        await sut.expect(\.entryTime, Date(timeIntervalSince1970: 9 * 60 * 60))  // 9:00 AM
        await sut.expect(\.exitTime, Date(timeIntervalSince1970: 9 * 60 * 60))
        await sut.send(.setExitTime(Date(timeIntervalSince1970: 9 * 60 * 60 + 2 * 60)))
        await sut.expect(\.exitTime, Date(timeIntervalSince1970: 9 * 60 * 60 + 2 * 60))
        await sut.expect(\.bottomTime, .minute(2))
    }

    @Test
    func setBottomTime() async {
        let sut = Store(
            reducer: LogbookAddReducer(),
            state: LogbookAddReducer.State()
        )
        await sut.expect(\.bottomTime, nil)
        await sut.send(.setBottomTime(12))
        await sut.expect(\.bottomTime, .minute(12))
        await sut.expect(\.exitTime, Date(timeIntervalSince1970: 9 * 60 * 60 + 12 * 60))
    }

    @Test
    func setSurfaceInterval() async {
        let sut = Store(
            reducer: LogbookAddReducer(),
            state: LogbookAddReducer.State()
        )
        await sut.expect(\.surfaceInterval, nil)
        await sut.send(.setSurfaceInterval(12))
        await sut.expect(\.surfaceInterval, .minute(12))
    }

    @Test
    func setEntryAir() async {
        let sut = Store(
            reducer: LogbookAddReducer(),
            state: LogbookAddReducer.State()
        )
        await sut.expect(\.entryAir, nil)
        await sut.send(.setEntryAir(12))
        await sut.expect(\.entryAir, .bar(12))
    }

    @Test
    func setExitAir() async {
        let sut = Store(
            reducer: LogbookAddReducer(),
            state: LogbookAddReducer.State()
        )
        await sut.expect(\.exitAir, nil)
        await sut.send(.setExitAir(12))
        await sut.expect(\.exitAir, .bar(12))
    }

    @Test
    func setMaximumDepth() async {
        let sut = Store(
            reducer: LogbookAddReducer(),
            state: LogbookAddReducer.State()
        )
        await sut.expect(\.maximumDepth, nil)
        await sut.send(.setMaximumDepth(12))
        await sut.expect(\.maximumDepth, .m(12))
    }

    @Test
    func setAverageDepth() async {
        let sut = Store(
            reducer: LogbookAddReducer(),
            state: LogbookAddReducer.State()
        )
        await sut.expect(\.averageDepth, nil)
        await sut.send(.setAverageDepth(12))
        await sut.expect(\.averageDepth, .m(12))
    }

    @Test
    func setSurfaceTemperature() async {
        let sut = Store(
            reducer: LogbookAddReducer(),
            state: LogbookAddReducer.State()
        )
        await sut.expect(\.surfaceTemperature, nil)
        await sut.send(.setSurfaceTemperature(12))
        await sut.expect(\.surfaceTemperature, .celsius(12))
    }

    @Test
    func setBottomTemperature() async {
        let sut = Store(
            reducer: LogbookAddReducer(),
            state: LogbookAddReducer.State()
        )
        await sut.expect(\.bottomTemperature, nil)
        await sut.send(.setBottomTemperature(12))
        await sut.expect(\.bottomTemperature, .celsius(12))
    }

    @Test
    func setWeather() async {
        let sut = Store(
            reducer: LogbookAddReducer(),
            state: LogbookAddReducer.State()
        )
        await sut.expect(\.weather, .sunny)
        await sut.send(.setWeather(.partlyCloudy))
        await sut.expect(\.weather, .partlyCloudy)
    }

    @Test
    func setFeeling() async {
        let sut = Store(
            reducer: LogbookAddReducer(),
            state: LogbookAddReducer.State()
        )
        await sut.expect(\.feeling, .good)
        await sut.send(.setFeeling(.amazing))
        await sut.expect(\.feeling, .amazing)
    }

    @Test
    func setNotes() async {
        let sut = Store(
            reducer: LogbookAddReducer(),
            state: LogbookAddReducer.State()
        )
        await sut.expect(\.notes, "")
        await sut.send(.setNotes("Hello\nWorld"))
        await sut.expect(\.notes, "Hello\nWorld")
    }

    @Test
    func setIsDiveSiteSearchSheetPresenting() async {
        let sut = Store(
            reducer: LogbookAddReducer(),
            state: LogbookAddReducer.State()
        )
        await sut.expect(\.isDiveSiteSearchSheetPresenting, false)
        await sut.send(.setIsDiveSiteSearchSheetPresenting(true))
        await sut.expect(\.isDiveSiteSearchSheetPresenting, true)
    }

    @Test
    func setIsLoading() async {
        let sut = Store(
            reducer: LogbookAddReducer(),
            state: LogbookAddReducer.State()
        )
        await sut.expect(\.isLoading, false)
        await sut.send(.setIsLoading(true))
        await sut.expect(\.isLoading, true)
    }
}
