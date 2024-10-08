import BadaApp
import BadaCore
import BadaUI

@main
struct MacApp: App {
    @Environment(\.scenePhase) private var scenePhase
    @StateObject private var store = ViewStore(
        reducer: AppReducer(),
        state: AppReducer.State()
    )

    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .onChange(of: scenePhase, initial: true) { _, newValue in
            switch newValue {
            case .background:
                store.send(.background)
            case .inactive:
                store.send(.inactive)
            case .active:
                store.send(.active)
            @unknown default:
                assertionFailure("Unknown scene phase")
            }
        }
    }
}
