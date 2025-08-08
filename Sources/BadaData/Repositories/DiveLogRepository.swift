//
//  Badabook
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

    package func insert(
        request: DiveLogInsertRequest
    ) -> Result<Void, DiveLogRepositoryError> {
        let entity = DiveLogEntity(insertRequest: request)
        context.insert(entity)
        do {
            try context.save()
            return .success(Void())
        } catch {
            return .failure(.insertFailed(error.localizedDescription))
        }
    }

    package func insertBatch(
        requests: [DiveLogInsertRequest]
    ) -> Result<Void, DiveLogRepositoryError> {
        do {
            try context.transaction {
                for request in requests {
                    let entity = DiveLogEntity(insertRequest: request)
                    context.insert(entity)
                }
                try context.save()
            }
            return .success(Void())
        } catch {
            return .failure(.insertBatchFailed(error.localizedDescription))
        }
    }

    package func fetchAll() -> Result<[DiveLog], DiveLogRepositoryError> {
        let descriptor = FetchDescriptor<DiveLogEntity>()
        do {
            let diveLogs = try context.fetch(descriptor)
            return .success(diveLogs.map(\.domain))
        } catch {
            return .failure(.fetchFailed(error.localizedDescription))
        }
    }

    package func fetch(
        by identifier: DiveLogID
    ) -> Result<DiveLog, DiveLogRepositoryError> {
        var descriptor = FetchDescriptor<DiveLogEntity>()
        descriptor.predicate = #Predicate { diveLog in
            diveLog.identifier == identifier
        }
        do {
            let diveLogs = try context.fetch(descriptor)
            if let diveLog = diveLogs.first {
                return .success(diveLog.domain)
            } else {
                return .failure(.noResult)
            }
        } catch {
            return .failure(.fetchFailed(error.localizedDescription))
        }
    }

    package func fetchLast() -> Result<DiveLog, DiveLogRepositoryError> {
        var descriptor = FetchDescriptor<DiveLogEntity>()
        descriptor.sortBy = [SortDescriptor(\.insertDate, order: .reverse)]
        descriptor.fetchLimit = 1
        do {
            let diveLogs = try context.fetch(descriptor)
            if let diveLog = diveLogs.first {
                return .success(diveLog.domain)
            } else {
                return .failure(.noResult)
            }
        } catch {
            return .failure(.fetchFailed(error.localizedDescription))
        }
    }

    package func update(
        request: DiveLogUpdateRequest
    ) -> Result<Void, DiveLogRepositoryError> {
        var descriptor = FetchDescriptor<DiveLogEntity>()
        let identifier = request.identifier
        descriptor.predicate = #Predicate { diveLog in
            diveLog.identifier == identifier
        }
        do {
            let diveLogs = try context.fetch(descriptor)
            if let diveLog = diveLogs.first {
                diveLog.update(with: request)
                try context.save()
                return .success(Void())
            } else {
                return .failure(.noResult)
            }
        } catch {
            return .failure(.updateFailed(error.localizedDescription))
        }
    }

    package func delete(for identifier: DiveLogID) -> Result<Void, DiveLogRepositoryError> {
        do {
            try context.delete(
                model: DiveLogEntity.self,
                where: #Predicate { diveLog in
                    diveLog.identifier == identifier
                },
                includeSubclasses: false
            )
            return .success(Void())
        } catch {
            return .failure(.deleteFailed(error.localizedDescription))
        }
    }

    package func deleteAll() -> Result<Void, DiveLogRepositoryError> {
        do {
            try context.delete(model: DiveLogEntity.self)
            return .success(Void())
        } catch {
            return .failure(.deleteFailed(error.localizedDescription))
        }
    }
}
