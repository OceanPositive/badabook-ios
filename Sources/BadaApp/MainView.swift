import BadaCore
import BadaUI

public struct MainView: View {
    @StateObject private var store = ViewStore(
        reducer: MainReducer(),
        state: MainReducer.State()
    )

    public init() { }

    public var body: some View {
        Text("BadaBook")
            .onAppear(perform: onAppear)
    }

    private func onAppear() {
        store.send(.load)
    }
}
