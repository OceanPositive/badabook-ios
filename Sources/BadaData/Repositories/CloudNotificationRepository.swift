//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain
import CoreData

package struct CloudNotificationRepository: CloudNotificationRepositoryType {
    package init() {}

    package func connect() -> AsyncStream<BadaDomain.CloudEvent> {
        AsyncStream<CloudEvent> { continuation in
            let events = NotificationCenter.default
                .notifications(named: NSPersistentCloudKitContainer.eventChangedNotification)
                .compactMap { notification in
                    let userInfoKey = NSPersistentCloudKitContainer.eventNotificationUserInfoKey
                    guard let event = notification.userInfo?[userInfoKey] as? NSPersistentCloudKitContainer.Event else { return nil as CloudEvent? }
                    return CloudEvent(
                        type: event.type.cloudEventType,
                        identifier: event.identifier,
                        storeIdentifier: event.storeIdentifier,
                        succeeded: event.succeeded,
                        startDate: event.startDate,
                        endDate: event.endDate,
                        error: event.error?.localizedDescription
                    )
                }
            Task { @Repository in
                for await event in events {
                    continuation.yield(event)
                }
            }
        }
    }
}

extension NSPersistentCloudKitContainer.EventType {
    fileprivate var cloudEventType: CloudEventType {
        switch self {
        case .setup:
            return CloudEventType.setup
        case .import:
            return CloudEventType.import
        case .export:
            return CloudEventType.export
        @unknown default:
            assertionFailure("Unknown cloud event type")
            return CloudEventType.setup
        }
    }
}
