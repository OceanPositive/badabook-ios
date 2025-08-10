//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore

package protocol ExecutableUseCase: Sendable {}

@propertyWrapper
package struct UseCase<T: ExecutableUseCase> {
    private let value: T

    package init() {
        self.value = UseCaseContainer.instance.resolve(T.self)
    }

    package var wrappedValue: T {
        get { value }
        set { assertionFailure("Assigning \(newValue) is unavailable") }
    }

    package var projectedValue: UseCase<T> {
        get { self }
        set { assertionFailure("Assigning \(newValue) is unavailable") }
    }
}

package final class UseCaseContainer: @unchecked Sendable {
    @TaskLocal
    package static var instance = UseCaseContainer()

    private let lock = NSLock()
    private var table: [UseCaseKey: any ExecutableUseCase] = [:]

    package init() {}

    package func register<T: ExecutableUseCase>(
        _ type: T.Type = T.self,
        build: () -> T
    ) {
        lock.lock()
        defer { lock.unlock() }
        let key = UseCaseKey(type: type)
        table[key] = build()
    }

    package func resolve<T: ExecutableUseCase>(
        _ type: T.Type = T.self
    ) -> T {
        lock.lock()
        defer { lock.unlock() }
        let key = UseCaseKey(type: type)
        guard let useCase = table[key] as? T else {
            fatalError("\(type) was not registered")
        }
        return useCase
    }

    package func reset() {
        lock.lock()
        defer { lock.unlock() }
        table.removeAll()
    }
}

private struct UseCaseKey: Hashable, Sendable {
    let type: String

    init(type: Any.Type) {
        self.type = "\(type)"
    }
}
