# SwiftData Entity Patterns

This reference documents the code patterns and structures used in the Badabook project for domain models, SwiftData entities, repositories, and use cases.

## 1. Domain Model (`BadaDomain/Models`)

Domain models are `package struct` types. They should be `Equatable`.

```swift
import BadaCore

package struct {Name}: Equatable {
    package let identifier: {Name}ID
    // ... fields

    package init(
        identifier: {Name}ID = {Name}ID(),
        // ... fields
    ) {
        self.identifier = identifier
        // ...
    }
}
```

## 2. Repository Interface (`BadaDomain/Interfaces`)

Define errors and the repository protocol. **Important: Always mark the protocol with `@Repository` to ensure it is isolated to the Repository global actor.**

```swift
import BadaCore

package enum {Name}RepositoryError: Error {
    case insertFailed(String)
    case fetchFailed(String)
    case updateFailed(String)
    case deleteFailed(String)
    case noResult
}

@Repository
package protocol {Name}RepositoryType: Sendable {
    func insert(request: {Name}InsertRequest) -> Result<Void, {Name}RepositoryError>
    func fetchAll() -> Result<[{Name}], {Name}RepositoryError>
    func update(request: {Name}UpdateRequest) -> Result<Void, {Name}RepositoryError>
    func delete(for identifier: {Name}ID) -> Result<Void, {Name}RepositoryError>
}
```

## 3. SwiftData Entity (`BadaData/Entities`)

The entity is a `@Model final class`. It implements `DomainConvertible`.

```swift
import BadaCore
import BadaDomain
import SwiftData

@Model
final class {Name}Entity {
    var identifier = {Name}ID()
    // ... fields

    init(
        identifier: {Name}ID,
        // ... fields
    ) {
        self.identifier = identifier
        // ...
    }
}

extension {Name}Entity: DomainConvertible {
    var domain: BadaDomain.{Name} {
        BadaDomain.{Name}(
            identifier: identifier,
            // ...
        )
    }

    convenience init(domain: BadaDomain.{Name}) {
        self.init(
            identifier: domain.identifier,
            // ...
        )
    }
}
```

## 4. Repository Implementation (`BadaData/Repositories`)

Implements the interface using `ModelContext`.

```swift
import BadaCore
import BadaDomain
import SwiftData

package struct {Name}Repository: {Name}RepositoryType {
    private let context: ModelContext

    package init(persistentStore: PersistentStore) {
        self.context = persistentStore.context
    }

    package func insert(request: {Name}InsertRequest) -> Result<Void, {Name}RepositoryError> {
        let entity = {Name}Entity(insertRequest: request)
        context.insert(entity)
        do {
            try context.save()
            return .success(Void())
        } catch {
            return .failure(.insertFailed(error.localizedDescription))
        }
    }

    // ... other methods
}
```

## 5. Use Cases (`BadaDomain/UseCases`)

Use cases are simple `ExecutableUseCase` structs wrapping a closure. Follow the Get, Post, Put, Delete naming conventions.

### Get (Fetch)
```swift
package struct Get{Name}sUseCase: ExecutableUseCase {
    private let get: @Sendable () async -> Result<[{Name}], {Name}RepositoryError>
    // ... init and execute
}
```

### Post (Create)
```swift
package struct Post{Name}UseCase: ExecutableUseCase {
    private let post: @Sendable ( {Name}InsertRequest ) async -> Result<Void, {Name}RepositoryError>
    // ... init and execute
}
```

### Patch/Put (Update)
Use `Patch` for partial updates and `Put` for complete replacements.
```swift
package struct Patch{Name}UseCase: ExecutableUseCase {
    private let patch: @Sendable ( {Name}UpdateRequest ) async -> Result<Void, {Name}RepositoryError>
    // ... init and execute
}
```

### Delete (Remove)
```swift
package struct Delete{Name}UseCase: ExecutableUseCase {
    private let delete: @Sendable ( {Name}ID ) async -> Result<Void, {Name}RepositoryError>
    // ... init and execute
}
```
