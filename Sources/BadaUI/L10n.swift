//
//  Badabook
//  Apache License, Version 2.0
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
        package static let profileSection = String(localized: "HOME_PROFILE_SECTION", bundle: .module)
        package static let profileCertification = String(localized: "HOME_PROFILE_CERTIFICATION", bundle: .module)
        package static let profileExperience = String(localized: "HOME_PROFILE_EXPERIENCE", bundle: .module)
        package static let summarySection = String(localized: "HOME_SUMMARY_SECTION", bundle: .module)
        package static let summaryLogs = String(localized: "HOME_SUMMARY_LOGS", bundle: .module)
        package static let summaryDiveSites = String(localized: "HOME_SUMMARY_DIVE_SITES", bundle: .module)
        package static let summaryTotalDiveTime = String(localized: "HOME_SUMMARY_TOTAL_DIVE_TIME", bundle: .module)
        package static let summaryLastDive = String(localized: "HOME_SUMMARY_LAST_DIVE", bundle: .module)
    }
    package enum Profile {
        package static let title = String(localized: "PROFILE_TITLE", bundle: .module)
        package static let name = String(localized: "PROFILE_NAME", bundle: .module)
        package static let notSet = String(localized: "PROFILE_NOT_SET", bundle: .module)
        package static let dateOfBirth = String(localized: "PROFILE_DATE_OF_BIRTH", bundle: .module)
        package static let certifications = String(localized: "PROFILE_CERTIFICATIONS", bundle: .module)
        package static let newCertification = String(localized: "PROFILE_NEW_CERTIFICATION", bundle: .module)
    }
    package enum Logbook {
        package static let title = String(localized: "LOGBOOK_TITLE", bundle: .module)
        package static let add = String(localized: "LOGBOOK_ADD", bundle: .module)
    }
    package enum MainTab {
        package static let equipment = String(localized: "MAIN_TAB_EQUIPMENT", bundle: .module)
        package static let home = String(localized: "MAIN_TAB_HOME", bundle: .module)
        package static let logbook = String(localized: "MAIN_TAB_LOGBOOK", bundle: .module)
    }
    package enum Common {
        package static let save = String(localized: "COMMON_SAVE", bundle: .module)
    }
}
