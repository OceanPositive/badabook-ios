import BadaCore
import BadaUI

struct LogbookView: View {
    @StateObject private var store = ViewStore(
        reducer: LogbookReducer(),
        state: LogbookReducer.State()
    )

    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {

            }
            .navigationTitle("Logbook")
        }
    }
}
