import SwiftUI

@main
struct ShowMdApp: App {
    var body: some Scene {
        WindowGroup("show.md") {
            ContentView()
        }
        .windowResizability(.contentSize)
        .defaultSize(width: 460, height: 480)
        .commands {
            CommandGroup(replacing: .newItem) {}
        }
    }
}
