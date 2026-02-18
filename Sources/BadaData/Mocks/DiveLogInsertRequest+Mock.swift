//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025-2026 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain

extension DiveLogInsertRequest {
    package static var mock: DiveLogInsertRequest {
        DiveLogInsertRequest(
            logNumber: Int.random(in: 1...1000),
            logDate: Date.now,
            diveSite: DiveSite(
                title: "Site \(Int.random(in: 1...50))",
                subtitle: "Country \(Int.random(in: 1...10))",
                coordinate: .none
            ).domain,
            diveCenter: ["Aqua Dive", "Blue Ocean", "Deep Sea Club"].randomElement(),
            diveStyle: [DiveStyle.boat, DiveStyle.beach, DiveStyle.night].randomElement()?.domain,
            entryTime: Date.now,
            exitTime: Date.now.addingTimeInterval(60 * Double(Int.random(in: 1...60))),
            // 45분 후
            surfaceInterval: .minute(Double.random(in: 10...90)),
            entryAir: .bar(Double.random(in: 180...220)),
            exitAir: .bar(Double.random(in: 20...60)),
            equipment: nil,
            maximumDepth: .m(Double.random(in: 10...40)),
            averageDepth: .m(Double.random(in: 5...20)),
            surfaceTemperature: .celsius(Double.random(in: 20...30)),
            bottomTemperature: .celsius(Double.random(in: 10...25)),
            weather: [Weather.sunny, Weather.cloudy, Weather.rainy].randomElement()?.domain,
            feeling: [Feeling.amazing, Feeling.average, Feeling.good].randomElement()?.domain,
            companions: [
                .buddy(name: "Alice"),
                .guide(name: "Bob", certificationLevel: .openWater),
                .buddy(name: "Charlie"),
                .guide(name: "Dana", certificationLevel: .diveMaster),
            ].shuffled().prefix(Int.random(in: 0...3)).map {
                $0
            },
            notes: "Mock log created at \(Date.now)"
        )
    }
}
