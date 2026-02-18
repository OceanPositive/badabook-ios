//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025-2026 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore

package struct ConnectCloudNotificationUseCase: ExecutableUseCase {
    private let connect: @Sendable () async -> AsyncStream<CloudEvent>

    package init(
        _ connect: @Sendable @escaping () async -> AsyncStream<CloudEvent>
    ) {
        self.connect = connect
    }

    package func execute() async -> AsyncStream<CloudEvent> {
        await connect()
    }
}
