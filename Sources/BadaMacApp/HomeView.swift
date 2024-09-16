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

            }
            .navigationTitle("Home")
        }
    }
}