//
//  Badabook
//  Apache License, Version 2.0
//
//  Copyright (c) 2025 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaUI

struct SplashView: View {
    var body: some View {
        Image(.appIcon128)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 128, height: 128)
    }
}
