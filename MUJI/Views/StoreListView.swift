import SwiftUI

struct StoreListView: View {
    @EnvironmentObject var viewModel: MUJIViewModel
    
    @State var isPresentingFilterView: Bool = false
    @State private var searchText: String = ""
    
    private var stores: [Store] {
        if searchText.isEmpty {
            return viewModel.stores
        } else {
            return viewModel.stores.filter { $0.name.contains(searchText) }
        }
    }
    
    
    var body: some View {
        NavigationView {
            List {
                if !viewModel.stores.isEmpty {
                    ForEach(stores) { store in
                        NavigationLink(destination: StoreDetailView(store: .constant(store))) {
                            Text(store.name)
                        }
                    }
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Stores")
            .toolbar {
                Button(action: {
                    isPresentingFilterView = true
                }) {
                    Image(systemName: "slider.horizontal.3")
                }
            }
            .sheet(isPresented: $isPresentingFilterView) {
                FilterView(isPresentingFilterView: $isPresentingFilterView)
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchStore()
            }
        }
    }
}

struct StoresView_Previews: PreviewProvider {
    static var previews: some View {
        StoreListView()
            .environmentObject(MUJIViewModel())
    }
}
