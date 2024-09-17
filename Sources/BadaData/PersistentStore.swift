//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import Foundation
import SwiftData
import BadaDomain

@Repository
enum PersistentStore {
    case main
    case mainTest

    var container: ModelContainer {
        switch self {
        case .main:
            return PersistentStore._mainContainer
        case .mainTest:
            return PersistentStore._mainTestContainer
        }
    }

    var context: ModelContext {
        switch self {
        case .main:
            return PersistentStore._mainContext
        case .mainTest:
            return PersistentStore._mainTestContext
        }
    }
}

extension PersistentStore {
    @Repository
    private static let _mainContainer: ModelContainer = {
        do {
            let container = try ModelContainer(
                for: DiveLogEntity.self,
                migrationPlan: PersistentStoreMigrationPlan.self,
                configurations: ModelConfiguration(
                    "com.enuf.badabook.badadata.main",
                    schema: Schema([DiveLogEntity.self]),
                    isStoredInMemoryOnly: false,
                    allowsSave: true,
                    groupContainer: ModelConfiguration.GroupContainer.identifier("com.enuf.badabook.badadata.main.group"),
                    cloudKitDatabase: ModelConfiguration.CloudKitDatabase.automatic
                )
            )
            return container
        } catch {
            fatalError("Failed to create container")
        }
    }()

    @Repository
    private static let _mainContext: ModelContext = {
        ModelContext(_mainContainer)
    }()

    @Repository
    private static let _mainTestContainer: ModelContainer = {
        do {
            let container = try ModelContainer(
                for: DiveLogEntity.self,
                migrationPlan: PersistentStoreMigrationPlan.self,
                configurations: ModelConfiguration(
                    "com.enuf.badabook.badadata.main-test",
                    schema: Schema([DiveLogEntity.self]),
                    isStoredInMemoryOnly: true,
                    allowsSave: true,
                    groupContainer: .none,
                    cloudKitDatabase: .none
                )
            )
            return container
        } catch {
            fatalError("Failed to create container")
        }
    }()

    @Repository
    private static let _mainTestContext: ModelContext = {
        ModelContext(_mainTestContainer)
    }()
}

enum PersistentStoreMigrationPlan: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] {
        [PersistentStoreSchemaV1.self]
    }

    static var stages: [MigrationStage] {
        []
    }
}

enum PersistentStoreSchemaV1: VersionedSchema {
    static var models: [any PersistentModel.Type] {
        [DiveLogEntity.self]
    }

    static var versionIdentifier: Schema.Version {
        Schema.Version(1, 0, 0)
    }
}
