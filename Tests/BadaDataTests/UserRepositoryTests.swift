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
struct UserRepositoryTests {
    let sut: UserRepository!

    init() async {
        sut = await UserRepository(persistentStore: PersistentStore.mainTest)
    }

    @Test
    func insertAndUpdate() async {
        let insertRequest = UserInsertRequest(
            name: "\(#line)",
            dateOfBirth: Date(timeIntervalSince1970: #line)
        )
        switch await sut.insert(request: insertRequest) {
        case .success:
            break
        case let .failure(error):
            Issue.record(error)
        }

        var spy: User?
        switch await sut.fetch() {
        case let .success(user):
            #expect(user.name == insertRequest.name)
            #expect(user.dateOfBirth == insertRequest.dateOfBirth)
            spy = user
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
            dateOfBirth: Date(timeIntervalSince1970: #line)
        )
        switch await sut.update(request: updateRequest) {
        case .success:
            break
        case let .failure(error):
            Issue.record(error)
        }

        switch await sut.fetch() {
        case let .success(user):
            #expect(user.name == updateRequest.name)
            #expect(user.dateOfBirth == updateRequest.dateOfBirth)
        case let .failure(error):
            Issue.record(error)
        }
    }
}
