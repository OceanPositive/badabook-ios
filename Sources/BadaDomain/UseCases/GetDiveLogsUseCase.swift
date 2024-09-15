import Foundation

package struct GetDiveLogsUseCase {
    private let diveLogs: () -> Result<[DiveLog], DiveLogRepositoryError>

    package init(
        diveLogs: @escaping () -> Result<[DiveLog], DiveLogRepositoryError>
    ) {
        self.diveLogs = diveLogs
    }

    package func execute() -> Result<[DiveLog], DiveLogRepositoryError> {
        diveLogs()
    }
}
