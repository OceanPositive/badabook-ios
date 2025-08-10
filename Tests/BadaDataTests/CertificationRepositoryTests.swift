//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain
import BadaTesting

@testable import BadaData

@Suite
struct CertificationRepositoryTests {
    let sut: CertificationRepository!

    init() async {
        sut = await CertificationRepository(persistentStore: PersistentStore.mainTest)
    }

    @Test
    func insert() async {
        let request = CertificationInsertRequest(
            agency: .padi,
            level: .openWater,
            number: "\(#line)",
            date: Date(timeIntervalSince1970: 12)
        )
        switch await sut.insert(request: request) {
        case .success:
            break
        case let .failure(error):
            Issue.record(error)
        }

        switch await sut.fetchAll() {
        case let .success(certifications):
            if let certification = certifications.first(where: { $0.number == request.number }) {
                #expect(certification.agency == request.agency)
                #expect(certification.level == request.level)
                #expect(certification.date == request.date)
            } else {
                Issue.record("No certification found.")
            }
        case let .failure(error):
            Issue.record(error)
        }
    }

    @Test
    func fetch() async {
        let insertRequest = CertificationInsertRequest(
            agency: .padi,
            level: .openWater,
            number: "\(#line)",
            date: Date(timeIntervalSince1970: 12)
        )
        switch await sut.insert(request: insertRequest) {
        case .success:
            break
        case let .failure(error):
            Issue.record(error)
        }

        var spy: Certification?
        switch await sut.fetchAll() {
        case let .success(certifications):
            if let certification = certifications.first(where: { $0.number == insertRequest.number }) {
                #expect(certification.agency == insertRequest.agency)
                #expect(certification.level == insertRequest.level)
                #expect(certification.date == insertRequest.date)
                spy = certification
            } else {
                Issue.record("No certification found.")
            }
        case let .failure(error):
            Issue.record(error)
        }

        guard let spy else {
            Issue.record("No certification found.")
            return
        }

        switch await sut.fetch(for: spy.identifier) {
        case let .success(certification):
            #expect(certification.agency == insertRequest.agency)
            #expect(certification.level == insertRequest.level)
            #expect(certification.date == insertRequest.date)
        case let .failure(error):
            Issue.record(error)
        }
    }

    @Test
    func update() async {
        let insertRequest = CertificationInsertRequest(
            agency: .padi,
            level: .openWater,
            number: "\(#line)",
            date: Date(timeIntervalSince1970: 12)
        )
        switch await sut.insert(request: insertRequest) {
        case .success:
            break
        case let .failure(error):
            Issue.record(error)
        }

        var spy: Certification?
        switch await sut.fetchAll() {
        case let .success(certifications):
            if let certification = certifications.first(where: { $0.number == insertRequest.number }) {
                #expect(certification.agency == insertRequest.agency)
                #expect(certification.level == insertRequest.level)
                #expect(certification.date == insertRequest.date)
                spy = certification
            } else {
                Issue.record("No certification found.")
            }
        case let .failure(error):
            Issue.record(error)
        }

        guard let spy else {
            Issue.record("No certification found.")
            return
        }

        let updateRequest = CertificationUpdateRequest(
            identifier: spy.identifier,
            agency: .scubapro,
            level: .advancedOpenWater,
            number: "\(#line)",
            date: Date(timeIntervalSince1970: 13)
        )
        switch await sut.update(request: updateRequest) {
        case .success:
            break
        case let .failure(error):
            Issue.record(error)
        }

        switch await sut.fetchAll() {
        case let .success(certifications):
            if let certification = certifications.first(where: { $0.number == updateRequest.number }) {
                #expect(certification.agency == updateRequest.agency)
                #expect(certification.level == updateRequest.level)
                #expect(certification.date == updateRequest.date)
            } else {
                Issue.record("No certification found.")
            }
        case let .failure(error):
            Issue.record(error)
        }
    }

    @Test
    func delete() async {
        let request = CertificationInsertRequest(
            agency: .padi,
            level: .openWater,
            number: "\(#line)",
            date: Date(timeIntervalSince1970: 12)
        )
        switch await sut.insert(request: request) {
        case .success:
            break
        case let .failure(error):
            Issue.record(error)
        }

        let identifier: CertificationID?
        switch await sut.fetchAll() {
        case let .success(certifications):
            if let certification = certifications.first(where: { $0.number == request.number }) {
                identifier = certification.identifier
            } else {
                Issue.record("No certification found.")
                identifier = nil
            }
        case let .failure(error):
            Issue.record(error)
            identifier = nil
        }

        guard let identifier else { return }
        switch await sut.delete(for: identifier) {
        case .success:
            break
        case let .failure(error):
            Issue.record(error)
        }

        switch await sut.fetch(for: identifier) {
        case let .success(certification):
            Issue.record("Not deleted yet.")
        case let .failure(error):
            #expect(error == .noResult)
        }
    }
}
