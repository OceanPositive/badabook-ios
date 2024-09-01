import BadaCore
import BadaUI
import SwiftUI

@main
struct PadApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    print(Hello.world())
                }
        }
    }
}
