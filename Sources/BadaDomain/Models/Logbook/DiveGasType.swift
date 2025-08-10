//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore

package enum DiveGasType: Equatable {
    case air
    case nitrox(oxygenPercentage: Int)
}
