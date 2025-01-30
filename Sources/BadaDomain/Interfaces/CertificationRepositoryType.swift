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
}

package enum CertificationRepositoryError: Error {
    case insertFailed(String)
    case fetchFailed(String)
    case updateFailed(String)
    case noResult
}
