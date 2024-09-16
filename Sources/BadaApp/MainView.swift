import BadaCore
import BadaUI

public struct MainView: View {
    @StateObject private var store = ViewStore(
        reducer: MainReducer(),
        state: MainReducer.State()
    )

    public init() { }

    public var body: some View {
        switch store.state.isLoaded {
        case true:
            HomeView()
        case false:
            SplashView()
                .onAppear(perform: onAppear)
        }
    }

    private func onAppear() {
        store.send(.load)
    }
}
