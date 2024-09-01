import BadaCore
import BadaUI
import SwiftUI

@main
struct PhoneApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    print(Hello.world())
                }
        }
    }
}
