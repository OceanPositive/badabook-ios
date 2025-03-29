//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain
import SwiftData

@Model
final class UserEntity {
    @Attribute(.unique)
    var identifier: UserID
    var name: String
    var birthDate: Date

    init(
        identifier: UserID,
        name: String,
        birthDate: Date
    ) {
        self.identifier = identifier
        self.name = name
        self.birthDate = birthDate
    }
}

extension UserEntity: DomainConvertible {
    var domain: BadaDomain.User {
        BadaDomain.User(
            identifier: identifier,
            name: name,
            birthDate: birthDate
        )
    }

    convenience init(domain: BadaDomain.User) {
        self.init(
            identifier: domain.identifier,
            name: domain.name,
            birthDate: domain.birthDate
        )
    }
}

extension UserEntity {
    convenience init(insertRequest: BadaDomain.UserInsertRequest) {
        self.init(
            identifier: UserID(),
            name: insertRequest.name,
            birthDate: insertRequest.birthDate
        )
    }

    func update(with updateRequest: UserUpdateRequest) {
        name = updateRequest.name
        birthDate = updateRequest.birthDate
    }
}
