import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            StoreListView()
                .tabItem {
                    Label("Stores", systemImage: "list.bullet")
                }
            MapView()
                .tabItem {
                    Label("Map", systemImage: "map")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
