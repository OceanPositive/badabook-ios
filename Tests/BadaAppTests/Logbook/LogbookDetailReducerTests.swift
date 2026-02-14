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
struct LogbookDetailReducerTests {
    init() {
        UseCaseContainer.instance.register {
            GetDiveLogUseCase { _ in .failure(.noResult) }
        }
        UseCaseContainer.instance.register {
            PutDiveLogUseCase { _ in .success(Void()) }
        }
        UseCaseContainer.instance.register {
            DeleteDiveLogUseCase { _ in .success(Void()) }
        }
    }

    @Test
    func load() async {
        let diveLog = DiveLog(
            identifier: DiveLogID(),
            logNumber: 1,
            logDate: Date(timeIntervalSince1970: 0),
            diveSite: DiveSite(title: "Test Site", subtitle: "Test Subtitle"),
            diveCenter: "Test Center",
            diveStyle: .boat,
            entryTime: Date(timeIntervalSince1970: 0),
            exitTime: Date(timeIntervalSince1970: 3600),
            surfaceInterval: .minute(60),
            entryAir: .bar(200),
            exitAir: .bar(50),
            maximumDepth: .m(30),
            averageDepth: .m(15),
            surfaceTemperature: .celsius(30),
            bottomTemperature: .celsius(20),
            weather: .sunny,
            feeling: .good,
            notes: "Test Notes"
        )

        let container = UseCaseContainer()
        container.register {
            GetDiveLogUseCase { _ in .success(diveLog) }
        }
        container.register {
            PutDiveLogUseCase { _ in .success(Void()) }
        }
        container.register {
            DeleteDiveLogUseCase { _ in .success(Void()) }
        }

        await UseCaseContainer.$instance.withValue(container) {
            let sut = Store(
                reducer: LogbookDetailReducer(),
                state: LogbookDetailReducer.State()
            )

            await sut.send(.load(diveLog.identifier))
            await sut.expect(\.origin, diveLog)
            await sut.expect(\.logNumber, 1)
            await sut.expect(\.logDate, Date(timeIntervalSince1970: 0))
            await sut.expect(\.diveSite, DiveSite(title: "Test Site", subtitle: "Test Subtitle"))
            await sut.expect(\.diveCenter, "Test Center")
            await sut.expect(\.diveStyle, .boat)
            await sut.expect(\.entryTime, Date(timeIntervalSince1970: 0))
            await sut.expect(\.exitTime, Date(timeIntervalSince1970: 3600))
            await sut.expect(\.surfaceInterval, .minute(60))
            await sut.expect(\.entryAir, .bar(200))
            await sut.expect(\.exitAir, .bar(50))
            await sut.expect(\.maximumDepth, .m(30))
            await sut.expect(\.averageDepth, .m(15))
            await sut.expect(\.surfaceTemperature, .celsius(30))
            await sut.expect(\.bottomTemperature, .celsius(20))
            await sut.expect(\.weather, .sunny)
            await sut.expect(\.feeling, .good)
            await sut.expect(\.notes, "Test Notes")
            await sut.expect(\.notesInitialized, true)
        }
    }

    @Test
    func save() async {
        let diveLog = DiveLog(
            identifier: DiveLogID(),
            logNumber: 1,
            logDate: Date(timeIntervalSince1970: 0),
            diveSite: nil
        )

        let sut = Store(
            reducer: LogbookDetailReducer(),
            state: LogbookDetailReducer.State(
                origin: diveLog,
                logNumber: 1
            )
        )

        await sut.send(.save)
        await sut.expect(\.shouldDismiss, true)
    }

    @Test
    func delete() async {
        let diveLog = DiveLog(
            identifier: DiveLogID(),
            logNumber: 1,
            logDate: Date(timeIntervalSince1970: 0),
            diveSite: nil
        )

        let sut = Store(
            reducer: LogbookDetailReducer(),
            state: LogbookDetailReducer.State(origin: diveLog)
        )

        await sut.send(.delete)
        await sut.expect(\.shouldDismiss, true)
    }

    @Test
    func dismiss() async {
        let sut = Store(
            reducer: LogbookDetailReducer(),
            state: LogbookDetailReducer.State()
        )

        await sut.send(.dismiss)
        await sut.expect(\.shouldDismiss, true)
    }

    @Test
    func setDiveLog() async {
        let diveLog = DiveLog(
            identifier: DiveLogID(),
            logNumber: 10,
            logDate: Date(timeIntervalSince1970: 100),
            diveSite: DiveSite(title: "Site", subtitle: "Sub")
        )

        let sut = Store(
            reducer: LogbookDetailReducer(),
            state: LogbookDetailReducer.State()
        )

        await sut.send(.setDiveLog(diveLog))
        await sut.expect(\.origin, diveLog)
        await sut.expect(\.logNumber, 10)
        await sut.expect(\.logDate, Date(timeIntervalSince1970: 100))
        await sut.expect(\.diveSite?.title, "Site")
    }

    @Test
    func setLogNumber() async {
        let sut = Store(
            reducer: LogbookDetailReducer(),
            state: LogbookDetailReducer.State()
        )

        await sut.expect(\.logNumber, nil)
        await sut.send(.setLogNumber(5))
        await sut.expect(\.logNumber, 5)
    }

    @Test
    func setLogDate() async {
        let sut = Store(
            reducer: LogbookDetailReducer(),
            state: LogbookDetailReducer.State()
        )

        let newDate = Date(timeIntervalSince1970: 123456)
        await sut.send(.setLogDate(newDate))
        await sut.expect(\.logDate, newDate)
    }

    @Test
    func setDiveSite() async {
        let sut = Store(
            reducer: LogbookDetailReducer(),
            state: LogbookDetailReducer.State()
        )

        let site = DiveSite(title: "New Site", subtitle: "New Sub")
        await sut.send(.setDiveSite(site))
        await sut.expect(\.diveSite, site)
    }

    @Test
    func setDiveSiteSearchResult() async {
        let sut = Store(
            reducer: LogbookDetailReducer(),
            state: LogbookDetailReducer.State()
        )

        let result = LocalSearchResult(
            title: "Result Title",
            subtitle: "Result Subtitle",
            coordinate: LocalSearchResult.Coordinate(latitude: 10, longitude: 20)
        )

        await sut.send(.setDiveSiteSearchResult(result))
        await sut.expect(\.diveSite?.title, "Result Title")
        await sut.expect(\.diveSite?.subtitle, "Result Subtitle")
        await sut.expect(\.diveSite?.coordinate?.latitude, 10)
        await sut.expect(\.diveSite?.coordinate?.longitude, 20)
    }

    @Test
    func setDiveCenter() async {
        let sut = Store(
            reducer: LogbookDetailReducer(),
            state: LogbookDetailReducer.State()
        )

        await sut.send(.setDiveCenter("New Center"))
        await sut.expect(\.diveCenter, "New Center")
    }

    @Test
    func setDiveStyle() async {
        let sut = Store(
            reducer: LogbookDetailReducer(),
            state: LogbookDetailReducer.State()
        )

        await sut.send(.setDiveStyle(.beach))
        await sut.expect(\.diveStyle, .beach)
    }

    @Test
    func setEntryTime() async {
        let sut = Store(
            reducer: LogbookDetailReducer(),
            state: LogbookDetailReducer.State()
        )

        // Initial state: entry 0, exit 0
        let newEntry = Date(timeIntervalSince1970: 60)
        await sut.send(.setEntryTime(newEntry))
        await sut.expect(\.entryTime, newEntry)
        // Exit is still 0. Interval = 0 - 60 = -60 seconds = -1 minute
        await sut.expect(\.bottomTime, .minute(-1))
    }

    @Test
    func setExitTime() async {
        let sut = Store(
            reducer: LogbookDetailReducer(),
            state: LogbookDetailReducer.State()
        )

        // Initial state: entry 0
        let newExit = Date(timeIntervalSince1970: 60)
        await sut.send(.setExitTime(newExit))
        await sut.expect(\.exitTime, newExit)
        // Interval = 60 - 0 = 60 seconds = 1 minute
        await sut.expect(\.bottomTime, .minute(1))
    }

    @Test
    func setBottomTime() async {
        let sut = Store(
            reducer: LogbookDetailReducer(),
            state: LogbookDetailReducer.State()
        )

        // Initial entry: 0
        await sut.send(.setBottomTime(30))  // 30 minutes
        await sut.expect(\.bottomTime, .minute(30))
        await sut.expect(\.exitTime, Date(timeIntervalSince1970: 30 * 60))
    }

    @Test
    func setSurfaceInterval() async {
        let sut = Store(
            reducer: LogbookDetailReducer(),
            state: LogbookDetailReducer.State()
        )

        await sut.send(.setSurfaceInterval(45))
        await sut.expect(\.surfaceInterval, .minute(45))
    }

    @Test
    func setEntryAir() async {
        let sut = Store(
            reducer: LogbookDetailReducer(),
            state: LogbookDetailReducer.State()
        )

        await sut.send(.setEntryAir(200))
        await sut.expect(\.entryAir, .bar(200))
    }

    @Test
    func setExitAir() async {
        let sut = Store(
            reducer: LogbookDetailReducer(),
            state: LogbookDetailReducer.State()
        )

        await sut.send(.setExitAir(50))
        await sut.expect(\.exitAir, .bar(50))
    }

    @Test
    func setMaximumDepth() async {
        let sut = Store(
            reducer: LogbookDetailReducer(),
            state: LogbookDetailReducer.State()
        )

        await sut.send(.setMaximumDepth(30))
        await sut.expect(\.maximumDepth, .m(30))
    }

    @Test
    func setAverageDepth() async {
        let sut = Store(
            reducer: LogbookDetailReducer(),
            state: LogbookDetailReducer.State()
        )

        await sut.send(.setAverageDepth(15))
        await sut.expect(\.averageDepth, .m(15))
    }

    @Test
    func setSurfaceTemperature() async {
        let sut = Store(
            reducer: LogbookDetailReducer(),
            state: LogbookDetailReducer.State()
        )

        await sut.send(.setSurfaceTemperature(30))
        await sut.expect(\.surfaceTemperature, .celsius(30))
    }

    @Test
    func setBottomTemperature() async {
        let sut = Store(
            reducer: LogbookDetailReducer(),
            state: LogbookDetailReducer.State()
        )

        await sut.send(.setBottomTemperature(20))
        await sut.expect(\.bottomTemperature, .celsius(20))
    }

    @Test
    func setWeather() async {
        let sut = Store(
            reducer: LogbookDetailReducer(),
            state: LogbookDetailReducer.State()
        )

        await sut.send(.setWeather(.rainy))
        await sut.expect(\.weather, .rainy)
    }

    @Test
    func setFeeling() async {
        let sut = Store(
            reducer: LogbookDetailReducer(),
            state: LogbookDetailReducer.State()
        )

        await sut.send(.setFeeling(.poor))
        await sut.expect(\.feeling, .poor)
    }

    @Test
    func setNotes() async {
        let sut = Store(
            reducer: LogbookDetailReducer(),
            state: LogbookDetailReducer.State()
        )

        await sut.send(.setNotes("New Notes"))
        await sut.expect(\.notes, "New Notes")
    }

    @Test
    func setNotesInitialized() async {
        let sut = Store(
            reducer: LogbookDetailReducer(),
            state: LogbookDetailReducer.State()
        )

        await sut.expect(\.notesInitialized, false)
        await sut.send(.setNotesInitialized)
        await sut.expect(\.notesInitialized, true)
    }

    @Test
    func setIsDiveSiteSearchSheetPresenting() async {
        let sut = Store(
            reducer: LogbookDetailReducer(),
            state: LogbookDetailReducer.State()
        )

        await sut.send(.setIsDiveSiteSearchSheetPresenting(true))
        await sut.expect(\.isDiveSiteSearchSheetPresenting, true)
    }
}
