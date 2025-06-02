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
    var dateOfBirth: Date
    var insertDate: Date
    var updateDate: Date

    init(
        identifier: UserID,
        name: String,
        dateOfBirth: Date,
        insertDate: Date,
        updateDate: Date
    ) {
        self.identifier = identifier
        self.name = name
        self.dateOfBirth = dateOfBirth
        self.insertDate = insertDate
        self.updateDate = updateDate
    }
}

extension UserEntity: DomainConvertible {
    var domain: BadaDomain.User {
        BadaDomain.User(
            identifier: identifier,
            name: name,
            dateOfBirth: dateOfBirth,
            insertDate: insertDate,
            updateDate: updateDate
        )
    }

    convenience init(domain: BadaDomain.User) {
        self.init(
            identifier: domain.identifier,
            name: domain.name,
            dateOfBirth: domain.dateOfBirth,
            insertDate: domain.insertDate,
            updateDate: domain.updateDate
        )
    }
}

extension UserEntity {
    convenience init(insertRequest: BadaDomain.UserInsertRequest) {
        self.init(
            identifier: UserID(),
            name: insertRequest.name,
            dateOfBirth: insertRequest.dateOfBirth,
            insertDate: Date.now,
            updateDate: Date.now
        )
    }

    func update(with updateRequest: UserUpdateRequest) {
        name = updateRequest.name
        dateOfBirth = updateRequest.dateOfBirth
        updateDate = Date.now
    }
}
