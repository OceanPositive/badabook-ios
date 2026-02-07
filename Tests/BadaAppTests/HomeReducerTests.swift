//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain
import BadaTesting

@testable import BadaApp

@Suite
struct HomeReducerTests {
    @Test
    func load() async {
        let container = UseCaseContainer()
        container.register {
            GetDiveLogsUseCase { .success([]) }
        }
        container.register {
            GetCertificationsUseCase { .success([]) }
        }
        container.register {
            ConnectCloudNotificationUseCase {
                AsyncStream<CloudEvent> { continuation in
                    continuation.finish()
                }
            }
        }
        await UseCaseContainer.$instance.withValue(container) {
            let sut = Store(
                reducer: HomeReducer(),
                state: HomeReducer.State()
            )
            await sut.expect(\.totalDiveLogCountText, "-")

            await sut.send(.load)
            await sut.expect(\.totalDiveLogCountText, "0")
        }
    }

    @Test
    func getCertifications() async {
        let certifications: [Certification] = [
            Certification(
                identifier: UUID(),
                agency: .padi,
                level: .openWater,
                number: "123",
                date: Date()
            )
        ]
        let container = UseCaseContainer()
        container.register {
            GetDiveLogsUseCase { .success([]) }
        }
        container.register {
            GetCertificationsUseCase { .success(certifications) }
        }
        container.register {
            ConnectCloudNotificationUseCase {
                AsyncStream<CloudEvent> { continuation in
                    continuation.finish()
                }
            }
        }
        await UseCaseContainer.$instance.withValue(container) {
            let sut = Store(
                reducer: HomeReducer(),
                state: HomeReducer.State()
            )
            await sut.send(.getCertifications)
            await sut.expect(\.certifications, certifications)
            await sut.expect(\.primaryCertificationText, "Open Water")
        }
    }

    @Test
    func setCertifications() async {
        let certifications: [Certification] = [
            Certification(
                identifier: UUID(),
                agency: .padi,
                level: .openWater,
                number: "123",
                date: Date(timeIntervalSince1970: 0)
            ),
            Certification(
                identifier: UUID(),
                agency: .padi,
                level: .advancedOpenWater,
                number: "124",
                date: Date(timeIntervalSince1970: 1000)
            ),
        ]

        let container = UseCaseContainer()
        container.register {
            GetDiveLogsUseCase { .success([]) }
        }
        container.register {
            GetCertificationsUseCase { .success([]) }
        }
        container.register {
            ConnectCloudNotificationUseCase {
                AsyncStream<CloudEvent> { continuation in
                    continuation.finish()
                }
            }
        }

        await UseCaseContainer.$instance.withValue(container) {
            let sut = Store(
                reducer: HomeReducer(),
                state: HomeReducer.State()
            )

            await sut.send(.setCertifications(certifications))
            await sut.expect(\.certifications, certifications)
            await sut.expect(\.primaryCertificationText, "Advanced Open Water")

            await sut.send(.setCertifications([]))
            await sut.expect(\.certifications, [])
            await sut.expect(\.primaryCertificationText, "-")
        }
    }

    @Test
    func getDiveLogs() async {
        let diveLogs: [DiveLog] = [
            DiveLog(logNumber: 0, logDate: Date(timeIntervalSince1970: 0)),
            DiveLog(logNumber: 1, logDate: Date(timeIntervalSince1970: 0)),
            DiveLog(logNumber: 2, logDate: Date(timeIntervalSince1970: 0)),
        ]
        let container = UseCaseContainer()
        container.register {
            GetDiveLogsUseCase { .success(diveLogs) }
        }
        container.register {
            GetCertificationsUseCase { .success([]) }
        }
        container.register {
            ConnectCloudNotificationUseCase {
                AsyncStream<CloudEvent> { continuation in
                    continuation.finish()
                }
            }
        }
        await UseCaseContainer.$instance.withValue(container) {
            let sut = Store(
                reducer: HomeReducer(),
                state: HomeReducer.State()
            )
            await sut.send(.getDiveLogs)
            await sut.expect(\.totalDiveLogCountText, "3")
        }
    }

    @Test
    func setDiveLogs() async {
        let diveLogs: [DiveLog] = [
            DiveLog(
                logNumber: 1,
                logDate: Date(timeIntervalSince1970: 0),
                diveSite: DiveSite(title: "Site A", subtitle: "Location A"),
                entryTime: Date(timeIntervalSince1970: 0),
                exitTime: Date(timeIntervalSince1970: 1800)  // 30 mins
            ),
            DiveLog(
                logNumber: 2,
                logDate: Date(timeIntervalSince1970: 86400),
                diveSite: DiveSite(title: "Site B", subtitle: "Location B"),
                entryTime: Date(timeIntervalSince1970: 86400),
                exitTime: Date(timeIntervalSince1970: 86400 + 3600)  // 60 mins
            ),
        ]  // Total time: 90 mins

        let container = UseCaseContainer()
        container.register {
            GetDiveLogsUseCase { .success([]) }
        }
        container.register {
            GetCertificationsUseCase { .success([]) }
        }
        container.register {
            ConnectCloudNotificationUseCase {
                AsyncStream<CloudEvent> { continuation in
                    continuation.finish()
                }
            }
        }

        await UseCaseContainer.$instance.withValue(container) {
            let sut = Store(
                reducer: HomeReducer(),
                state: HomeReducer.State()
            )

            await sut.send(.setDiveLogs(diveLogs))
            await sut.expect(\.diveLogs, diveLogs)
            await sut.expect(\.totalDiveLogCountText, "2")
            await sut.expect(\.totalDiveSiteCountText, "2")
        }
    }

    @Test
    func handleCloudEvent() async {
        let container = UseCaseContainer()
        container.register {
            GetDiveLogsUseCase { .success([]) }
        }
        container.register {
            GetCertificationsUseCase { .success([]) }
        }
        container.register {
            ConnectCloudNotificationUseCase {
                AsyncStream<CloudEvent> { continuation in
                    continuation.finish()
                }
            }
        }

        await UseCaseContainer.$instance.withValue(container) {
            let sut = Store(
                reducer: HomeReducer(),
                state: HomeReducer.State()
            )

            // .setup event -> no effect
            await sut.send(
                .handleCloudEvent(
                    CloudEvent(
                        type: .setup,
                        identifier: UUID(),
                        storeIdentifier: "store",
                        succeeded: true,
                        startDate: Date(),
                        endDate: nil,
                        error: nil
                    )))

            // .export event -> no effect
            await sut.send(
                .handleCloudEvent(
                    CloudEvent(
                        type: .export,
                        identifier: UUID(),
                        storeIdentifier: "store",
                        succeeded: true,
                        startDate: Date(),
                        endDate: nil,
                        error: nil
                    )))

            // .import event -> loads
            await sut.send(
                .handleCloudEvent(
                    CloudEvent(
                        type: .import,
                        identifier: UUID(),
                        storeIdentifier: "store",
                        succeeded: true,
                        startDate: Date(),
                        endDate: nil,
                        error: nil
                    )))
        }
    }
}
