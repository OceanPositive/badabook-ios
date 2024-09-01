import BadaCore
import BadaUI
import SwiftUI

@main
struct MacApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    print(Hello.world())
                }
        }
    }
}
