import Foundation
import SwiftData
import BadaDomain

package struct DiveLogRepository: DiveLogRepositoryType {
    private let context: ModelContext

    init(persistentStore: PersistentStore) {
        self.context = persistentStore.context
    }

    package func insert(diveLog: DiveLog) -> Result<Void, DiveLogRepositoryError> {
        let entity = DiveLogEntity(domain: diveLog)
        context.insert(entity)
        do {
            try context.save()
            return .success(())
        } catch {
            return .failure(.fetchFailed(error.localizedDescription))
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