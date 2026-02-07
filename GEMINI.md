# GEMINI.md - Project Overview

## Project: Badabook iOS

**Goal**: An iOS application for logging and managing diving activities (implied by "Bada" - Korean for Sea/Ocean, and "Logbook"/"Equipment" directories).

## Tech Stack

- **Language**: Swift
- **Framework**: SwiftUI
- **Package Manager**: Swift Package Manager (SPM)
- **Architecture**: Modular Architecture + Clean Architecture + Unidirectional Data Flow (UDF)
- **State Management**: [OneWay](https://github.com/DevYeom/OneWay)
- **Minimum iOS Version**: iOS 18.0

## Project Structure

The project is organized as a Swift Package with multiple targets, promoting separation of concerns.

### Modules (Targets)

- **BadaApp**: The main application target. Contains the App entry point, Feature views (Home, Logbook, Equipment), and the composition of other modules.
- **BadaDomain**: The business logic layer. Contains:
    - `Models`: Data structures.
    - `UseCases`: Business logic operations.
    - `Interfaces`: Protocols for repositories and services.
- **BadaData**: The data access layer. Implements repositories defined in `BadaDomain`.
- **BadaCore**: Core utilities, extensions, and shared infrastructure.
- **BadaUI**: Reusable UI components and design system elements.
- **BadaTesting**: Shared testing helpers and mocks.

### Key Directories

- `Sources/BadaApp`: Main feature code.
    - `AppReducer.swift`: Root state reducer.
    - `MainView.swift`: Main UI entry point.
    - `Home/`, `Logbook/`, `Equipment/`: Feature-specific code.
- `Sources/BadaDomain`:
    - `UseCases/`: Application business rules.
    - `Models/`: Domain entities.
- `App/`: Contains the `.xcodeproj` wrapper for the package (if used).

## Development

- **Setup**: Clone the repo and open `App/AppProject.xcodeproj` or the root folder in Xcode.
- **Running**: Select the `iOS` scheme and target a simulator or device.
- **Tests**: Run `make test-all` to test for all platforms.
- **Linting & Formatting**: Run `make lint` to check and fix coding style issues using `swift-format`.

## Notes for AI Assistant

- When implementing new features, ensure to follow the Clean Architecture layers:
    1. Define Entity in `BadaDomain/Models`.
    2. Define Repository Interface in `BadaDomain/Interfaces`.
    3. Implement UseCase in `BadaDomain/UseCases`.
    4. Implement Repository in `BadaData`.
    5. Implement UI/Reducer in `BadaApp` using `OneWay`.
- Check `Package.swift` for dependency management.
