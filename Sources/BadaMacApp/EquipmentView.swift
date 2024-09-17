import BadaCore
import BadaUI

struct EquipmentView: View {
    @StateObject private var store = ViewStore(
        reducer: EquipmentReducer(),
        state: EquipmentReducer.State()
    )

    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {

            }
            .navigationTitle("My Equipment")
        }
    }
}
