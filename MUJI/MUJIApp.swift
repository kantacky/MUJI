import SwiftUI

@main
struct MUJIApp: App {
    @StateObject private var mujiViewModel = MUJIViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(mujiViewModel)
        }
    }
}
