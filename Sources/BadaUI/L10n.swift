//
//  BadaBook
//  Apache License Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

package enum L10n {
    package enum App {
        package static let title = String(localized: "APP_TITLE", bundle: .module)
    }
    package enum Equipment {
        package static let title = String(localized: "EQUIPMENT_TITLE", bundle: .module)
    }
    package enum Home {
        package static let title = String(localized: "HOME_TITLE", bundle: .module)
    }
    package enum Logbook {
        package static let title = String(localized: "LOGBOOK_TITLE", bundle: .module)
    }
    package enum MainTab {
        package static let equipment = String(localized: "MAIN_TAB_EQUIPMENT", bundle: .module)
        package static let home = String(localized: "MAIN_TAB_HOME", bundle: .module)
        package static let logbook = String(localized: "MAIN_TAB_LOGBOOK", bundle: .module)
    }
}
