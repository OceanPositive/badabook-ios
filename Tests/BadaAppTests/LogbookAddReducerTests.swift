//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain
import BadaTesting

@testable import BadaApp

struct LogbookAddReducerTests {
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
        await sut.expect(\.logDate, Date(timeIntervalSince1970: 0))
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
        let searchResult = LocalSearchResult(
            title: "Hello",
            subtitle: "World",
            coordinate: LocalSearchResult.Coordinate(latitude: 12, longitude: 13)
        )
        await sut.send(.setDiveSite(searchResult))
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
        await sut.expect(\.entryTime, Date(timeIntervalSince1970: 0))
        await sut.expect(\.exitTime, Date(timeIntervalSince1970: 0))
        await sut.send(.setEntryTime(Date(timeIntervalSince1970: 2 * 60)))
        await sut.expect(\.entryTime, Date(timeIntervalSince1970: 2 * 60))
        await sut.expect(\.bottomTime, .minute(-2))
    }

    @Test
    func setExitTime() async {
        let sut = Store(
            reducer: LogbookAddReducer(),
            state: LogbookAddReducer.State()
        )
        await sut.expect(\.entryTime, Date(timeIntervalSince1970: 0))
        await sut.expect(\.exitTime, Date(timeIntervalSince1970: 0))
        await sut.send(.setExitTime(Date(timeIntervalSince1970: 2 * 60)))
        await sut.expect(\.exitTime, Date(timeIntervalSince1970: 2 * 60))
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
        await sut.expect(\.exitTime, Date(timeIntervalSince1970: 12 * 60))
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
    func setAirTemperature() async {
        let sut = Store(
            reducer: LogbookAddReducer(),
            state: LogbookAddReducer.State()
        )
        await sut.expect(\.airTemperature, nil)
        await sut.send(.setAirTemperature(12))
        await sut.expect(\.airTemperature, .celsius(12))
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
}
