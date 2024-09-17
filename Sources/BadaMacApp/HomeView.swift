//
//  BadaBook
//  Apache License, Version 2.0
//
//  Copyright (c) 2024 Seungyeop Yeom ( https://github.com/OceanPositive ).
//

import BadaCore
import BadaUI

struct HomeView: View {
    @StateObject private var store = ViewStore(
        reducer: HomeReducer(),
        state: HomeReducer.State()
    )

    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(spacing: 16) {
                    HStack(spacing: 16) {
                        StatusView(
                            icon: .number,
                            title: "Logs",
                            value: "100",
                            background: .tertiary
                        )
                        StatusView(
                            icon: .personTextRectangle,
                            title: "License",
                            value: "Open water",
                            background: .cyan
                        )
                    }
                    HStack(spacing: 16) {
                        StatusView(
                            icon: .stopwatch,
                            title: "Total time",
                            value: "323h 40m",
                            background: .orange
                        )
                        StatusView(
                            icon: .calendar,
                            title: "Last dive",
                            value: "30d ago",
                            background: .mint
                        )
                    }
                }
                .padding(16)
            }
            .navigationTitle(L10n.Home.title)
        }
    }
}

extension HomeView {
    private struct StatusView<Background>: View where Background: ShapeStyle {
        var icon: SystemImage
        var title: String
        var value: String
        var background: Background

        var body: some View {
            VStack(spacing: 16) {
                HStack(spacing: 4) {
                    Image(systemImage: icon)
                    Text(title)
                    Spacer()
                }
                .font(.headline)
                HStack(spacing: 0) {
                    Spacer()
                    Text(value)
                        .font(.system(.title3, design: .rounded))
                }
            }
            .padding(16)
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(background)
            }
        }
    }
}

#Preview {
    HomeView()
}
