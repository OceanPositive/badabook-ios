//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore

@Repository
package protocol CertificationRepositoryType {
    func insert(request: CertificationInsertRequest) -> Result<Void, CertificationRepositoryError>
    func fetchAll() -> Result<[Certification], CertificationRepositoryError>
    func fetch(for identifier: CertificationID) -> Result<Certification, CertificationRepositoryError>
    func update(request: CertificationUpdateRequest) -> Result<Void, CertificationRepositoryError>
    func delete(for identifier: CertificationID) -> Result<Void, CertificationRepositoryError>
}

package enum CertificationRepositoryError: Error, Equatable {
    case insertFailed(String)
    case fetchFailed(String)
    case updateFailed(String)
    case deleteFailed(String)
    case noResult
}
