//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain
import BadaTesting

@testable import BadaData

@Suite
struct UserRepositoryTests {
    let sut: UserRepository!

    init() async {
        sut = await UserRepository(persistentStore: PersistentStore.mainTest)
    }

    @Test
    func insert() async {
        let request = UserInsertRequest(
            name: "\(#line)",
            birthDate: Date(timeIntervalSince1970: #line)
        )
        switch await sut.insert(request: request) {
        case .success:
            break
        case let .failure(error):
            Issue.record(error)
        }

        switch await sut.fetchAll() {
        case let .success(users):
            if let user = users.first(where: { $0.name == request.name }) {
                #expect(user.birthDate == request.birthDate)
            } else {
                Issue.record("No user found.")
            }
        case let .failure(error):
            Issue.record(error)
        }
    }

    @Test
    func fetch() async {
        let request = UserInsertRequest(
            name: "\(#line)",
            birthDate: Date(timeIntervalSince1970: #line)
        )
        switch await sut.insert(request: request) {
        case .success:
            break
        case let .failure(error):
            Issue.record(error)
        }

        var spy: User?
        switch await sut.fetchAll() {
        case let .success(users):
            if let user = users.first(where: { $0.name == request.name }) {
                #expect(user.birthDate == request.birthDate)
                spy = user
            } else {
                Issue.record("No user found.")
            }
        case let .failure(error):
            Issue.record(error)
        }

        guard let spy else {
            Issue.record("No user found.")
            return
        }

        switch await sut.fetch(for: spy.identifier) {
        case let .success(user):
            #expect(user.birthDate == request.birthDate)
        case let .failure(error):
            Issue.record(error)
        }
    }

    @Test
    func update() async {
        let insertRequest = UserInsertRequest(
            name: "\(#line)",
            birthDate: Date(timeIntervalSince1970: #line)
        )
        switch await sut.insert(request: insertRequest) {
        case .success:
            break
        case let .failure(error):
            Issue.record(error)
        }

        var spy: User?
        switch await sut.fetchAll() {
        case let .success(users):
            if let user = users.first(where: { $0.name == insertRequest.name }) {
                #expect(user.birthDate == insertRequest.birthDate)
                spy = user
            } else {
                Issue.record("No user found.")
            }
        case let .failure(error):
            Issue.record(error)
        }

        guard let spy else {
            Issue.record("No user found.")
            return
        }

        let updateRequest = UserUpdateRequest(
            identifier: spy.identifier,
            name: "\(#line)",
            birthDate: Date(timeIntervalSince1970: #line)
        )
        switch await sut.update(request: updateRequest) {
        case .success:
            break
        case let .failure(error):
            Issue.record(error)
        }

        switch await sut.fetchAll() {
        case let .success(users):
            if let user = users.first(where: { $0.name == updateRequest.name }) {
                #expect(user.birthDate == updateRequest.birthDate)
            } else {
                Issue.record("No user found.")
            }
        case let .failure(error):
            Issue.record(error)
        }
    }
}
