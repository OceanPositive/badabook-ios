//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain
import SwiftData

package struct DiveLogRepository: DiveLogRepositoryType {
    private let context: ModelContext

    package init(persistentStore: PersistentStore) {
        self.context = persistentStore.context
    }

    package func insert(diveLog: DiveLog) -> Result<Void, DiveLogRepositoryError> {
        let entity = DiveLogEntity(domain: diveLog)
        context.insert(entity)
        do {
            try context.save()
            return .success(())
        } catch {
            return .failure(.insertFailed(error.localizedDescription))
        }
    }

    package func diveLogs() -> Result<[DiveLog], DiveLogRepositoryError> {
        let descriptor = FetchDescriptor<DiveLogEntity>()
        do {
            let diveLogs = try context.fetch(descriptor)
            return .success(diveLogs.map(\.domain))
        } catch {
            return .failure(.fetchFailed(error.localizedDescription))
        }
    }
}
