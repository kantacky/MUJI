import SwiftUI

struct FilterView: View {
    @Binding var isPresentingFilterView: Bool
    
    var body: some View {
        NavigationView {
            Form {
                
            }
            .navigationTitle("Filter")
            .toolbar {
                Button(action: {
                    isPresentingFilterView = false
                }) {
                    Text("Done")
                }
            }
        }
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(isPresentingFilterView: .constant(true))
    }
}
