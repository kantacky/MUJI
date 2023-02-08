import SwiftUI

struct StoreDetailView: View {
    @Binding var store: Store
    
    var body: some View {
        List {
            HStack {
                Text("Name")
                Spacer()
                Text(store.name)
            }
            
            HStack {
                Text("Address")
                Spacer()
                Text(store.address)
                    .font(.caption2)
                    .multilineTextAlignment(.trailing)
            }
            
            HStack {
                Text("Store ID")
                Spacer()
                Text(store.id)
            }
            
            SmallMapView(stores: [store])
                .frame(minHeight: 300.0)
            
            if let mapUrl = URL(string: "maps://?saddr=&daddr=\(store.latitude),\(store.longitude)") {
                Link(destination: mapUrl) {
                    HStack {
                        Image(systemName: "map")
                            .font(.caption)
                        Text("Open in Maps")
                    }
                }
            }
            
            if let storeDetailUrl = URL(string: "https://www.muji.com/jp/ja/shop/detail/\(store.id)") {
                Link(destination: storeDetailUrl) {
                    HStack {
                        Image(systemName: "list.bullet")
                            .font(.caption)
                        Text("Detail Page (Web)")
                    }
                }
            }
        }
        .navigationTitle("Store Detail")
    }
}

struct StoreDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StoreDetailView(store: .constant(Store.sampleData[0]))
    }
}
