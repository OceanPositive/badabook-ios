//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore

@Repository
package protocol CloudNotificationRepositoryType {
    func connect() -> AsyncStream<CloudEvent>
}
