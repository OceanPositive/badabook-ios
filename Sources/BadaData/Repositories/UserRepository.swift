//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain
import SwiftData

package struct UserRepository: UserRepositoryType {
    private let context: ModelContext

    package init(persistentStore: PersistentStore) {
        self.context = persistentStore.context
    }

    package func insert(
        request: UserInsertRequest
    ) -> Result<Void, UserRepositoryError> {
        let entity = UserEntity(insertRequest: request)
        context.insert(entity)
        do {
            try context.save()
            return .success(Void())
        } catch {
            return .failure(.insertFailed(error.localizedDescription))
        }
    }

    package func fetch() -> Result<User, UserRepositoryError> {
        let descriptor = FetchDescriptor<UserEntity>()
        do {
            let users = try context.fetch(descriptor)
            if let user = users.first {
                return .success(user.domain)
            } else {
                return .failure(.noResult)
            }
        } catch {
            return .failure(.fetchFailed(error.localizedDescription))
        }
    }

    package func update(
        request: UserUpdateRequest
    ) -> Result<Void, UserRepositoryError> {
        var descriptor = FetchDescriptor<UserEntity>()
        let identifier = request.identifier
        descriptor.predicate = #Predicate { user in
            user.identifier == identifier
        }
        do {
            let users = try context.fetch(descriptor)
            if let user = users.first {
                user.update(with: request)
                try context.save()
                return .success(Void())
            } else {
                return .failure(.noResult)
            }
        } catch {
            return .failure(.updateFailed(error.localizedDescription))
        }
    }
}
