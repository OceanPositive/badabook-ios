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
                        let logCountValue =
                            switch store.state.logCount {
                            case let .some(logCount):
                                "\(logCount)"
                            case .none:
                                nil as String?
                            }
                        StatusView(
                            icon: .number,
                            title: "Logs",
                            value: logCountValue,
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
            .onAppear(perform: onAppear)
        }
    }

    private func onAppear() {
        store.send(.initialize)
    }
}

extension HomeView {
    private struct StatusView<Background>: View where Background: ShapeStyle {
        var icon: SystemImage
        var title: String
        var value: String?
        var background: Background

        var body: some View {
            VStack(spacing: 16) {
                HStack(spacing: 4) {
                    Image(systemImage: icon)
                    Text(title)
                    Spacer()
                }
                .font(.system(.headline, weight: .regular))
                HStack(spacing: 0) {
                    Spacer()
                    if let value {
                        Text(value)
                            .font(.system(.title3, design: .rounded, weight: .medium))
                    } else {
                        ProgressView()
                    }
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
