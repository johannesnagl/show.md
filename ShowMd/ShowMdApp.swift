import SwiftUI

@main
struct ShowMdApp: App {
    var body: some Scene {
        WindowGroup("show.md") {
            ContentView()
        }
        .windowResizability(.contentSize)
        .defaultSize(width: 420, height: 420)
        .commands {
            CommandGroup(replacing: .newItem) {}
        }
    }
}
