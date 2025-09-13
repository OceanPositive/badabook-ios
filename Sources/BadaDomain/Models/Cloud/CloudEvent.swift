//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore

package struct CloudEvent: Equatable {
    package let type: CloudEventType
    package let identifier: UUID
    package let storeIdentifier: String
    package let succeeded: Bool
    package let startDate: Date
    package let endDate: Date?
    package let error: String?

    package init(
        type: CloudEventType,
        identifier: UUID,
        storeIdentifier: String,
        succeeded: Bool,
        startDate: Date,
        endDate: Date?,
        error: String?
    ) {
        self.type = type
        self.identifier = identifier
        self.storeIdentifier = storeIdentifier
        self.succeeded = succeeded
        self.startDate = startDate
        self.endDate = endDate
        self.error = error
    }
}
