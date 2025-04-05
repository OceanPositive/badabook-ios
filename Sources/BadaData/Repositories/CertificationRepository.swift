//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaDomain
import SwiftData

package struct CertificationRepository: CertificationRepositoryType {
    private let context: ModelContext

    package init(persistentStore: PersistentStore) {
        self.context = persistentStore.context
    }

    package func insert(
        request: CertificationInsertRequest
    ) -> Result<Void, CertificationRepositoryError> {
        let entity = CertificationEntity(insertRequest: request)
        context.insert(entity)
        do {
            try context.save()
            return .success(Void())
        } catch {
            return .failure(.insertFailed(error.localizedDescription))
        }
    }

    package func fetchAll() -> Result<[Certification], CertificationRepositoryError> {
        let descriptor = FetchDescriptor<CertificationEntity>()
        do {
            let certifications = try context.fetch(descriptor)
            return .success(certifications.map(\.domain))
        } catch {
            return .failure(.fetchFailed(error.localizedDescription))
        }
    }

    package func fetch(
        for identifier: CertificationID
    ) -> Result<Certification, CertificationRepositoryError> {
        var descriptor = FetchDescriptor<CertificationEntity>()
        descriptor.predicate = #Predicate { certification in
            certification.identifier == identifier
        }
        do {
            let certifications = try context.fetch(descriptor)
            if let certification = certifications.first {
                return .success(certification.domain)
            } else {
                return .failure(.noResult)
            }
        } catch {
            return .failure(.fetchFailed(error.localizedDescription))
        }
    }

    package func update(
        request: CertificationUpdateRequest
    ) -> Result<Void, CertificationRepositoryError> {
        var descriptor = FetchDescriptor<CertificationEntity>()
        let identifier = request.identifier
        descriptor.predicate = #Predicate { certification in
            certification.identifier == identifier
        }
        do {
            let certifications = try context.fetch(descriptor)
            if let certification = certifications.first {
                certification.update(with: request)
                try context.save()
                return .success(Void())
            } else {
                return .failure(.noResult)
            }
        } catch {
            return .failure(.updateFailed(error.localizedDescription))
        }
    }

    package func delete(
        for identifier: CertificationID
    ) -> Result<Void, CertificationRepositoryError> {
        do {
            try context.delete(
                model: CertificationEntity.self,
                where: #Predicate { certification in
                    certification.identifier == identifier
                },
                includeSubclasses: false
            )
            return .success(Void())
        } catch {
            return .failure(.deleteFailed(error.localizedDescription))
        }
    }
}
