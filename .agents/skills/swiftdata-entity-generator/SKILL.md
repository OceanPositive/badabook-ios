---
name: swiftdata-entity-generator
description: Generates SwiftData entities, repositories, and use cases following the project's Clean Architecture and modular structure. Use this skill when the user wants to add new data entities or create a complete data layer for a new feature.
---

# SwiftData Entity Generator

This skill automates the creation of the data layer for new features in the Badabook project, ensuring consistency with Clean Architecture and SwiftData best practices.

## Workflow

1.  **Define Domain Model**: Create a struct in `Sources/BadaDomain/Models/{Feature}/{Name}.swift`.
2.  **Define Repository Interface**: Create a protocol in `Sources/BadaDomain/Interfaces/{Name}RepositoryType.swift`.
3.  **Implement SwiftData Entity**: Create a `@Model` class in `Sources/BadaData/Entities/{Name}Entity.swift`.
4.  **Implement Repository**: Create a struct in `Sources/BadaData/Repositories/{Name}Repository.swift`.
5.  **Create Use Cases**: Create `ExecutableUseCase` structs in `Sources/BadaDomain/UseCases/{Feature}/`.

## Patterns and Templates

Refer to [patterns.md](references/patterns.md) for detailed code templates for each layer.

## Key Considerations

- **UseCase Naming**: Strictly follow these prefixes for UseCases:
    - **Get**: For fetching or reading data (e.g., `Get{Name}sUseCase`, `Get{Name}UseCase`).
    - **Post**: For adding or creating new data (e.g., `Post{Name}UseCase`).
    - **Put**: For completely replacing or overwriting existing data (e.g., `Put{Name}UseCase`).
    - **Patch**: For partially modifying or updating existing data (e.g., `Patch{Name}UseCase`).
    - **Delete**: For removing data (e.g., `Delete{Name}UseCase`).
- **Modular Access**: Use `package` access level for types that need to be shared across targets (e.g., Domain models, Repository interfaces).
- **Domain Mapping**: Use `DomainConvertible` protocol to map between `Entity` (SwiftData) and `Domain Model`.
- **Error Handling**: Use `Result` type with feature-specific repository errors.
- **Entity Dates**: All SwiftData Entities (`@Model` classes) must include `insertDate: Date` and `updateDate: Date` fields to track creation and modification times.
- **Constructor Default Values**: Never use default parameter values (e.g., `= nil` or default dates) in the initializers of Entities (`*Entity.swift`), Domain models (`Profile.swift`, etc.), or Data Transfer Objects/Request models (`*Request.swift`). All parameters must be explicitly provided at the call site.
- **Dependencies**: Ensure new entities are added to the `ModelContainer` in `PersistentStore.swift` if necessary.

## Example Trigger

- "Create a new entity for `DiveSite` with fields name, latitude, longitude."
- "Generate repository and use cases for `Certification`."
- "I need to add a `Gear` entity to the project."
