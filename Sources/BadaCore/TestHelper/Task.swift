//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

/// https://github.com/pointfreeco/swift-concurrency-extras/blob/1.1.0/Sources/ConcurrencyExtras/Task.swift#L15
extension Task where Success == Never, Failure == Never {
    package static func megaYield(count: Int = 10) async {
        for _ in 0..<count {
            await Task<Void, Never>.detached(priority: .background) { await Task.yield() }.value
        }
    }
}
