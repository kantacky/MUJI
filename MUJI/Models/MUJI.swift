import Foundation
import SwiftUI
import CoreLocation

class MUJIViewModel: ObservableObject {
    
    @Published private(set) var stores: [Store] = []
    let storeLoader = StoreLoader()
    
    func fetchStore() async {
        let stores = try? await storeLoader.loadStore()
        await MainActor.run {
            self.stores = stores ?? []
        }
    }
}

class StoreLoader {
    
    func handleResponse(data: Data?, response: URLResponse?) -> [Store]? {
        guard
            let data = data,
            let response = response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300
        else {
            return nil
        }
        
        let wrappedValue = try! JSONDecoder().decode(StoreWrapper.self, from: data)
        let stores = wrappedValue.data
        
        return stores
    }
    
    func loadStore() async throws -> [Store]? {
        let endpoint = URL(string: "\(EnvironmentVariables.apiBaseUrl)/store?order_by=id")!
        var request = URLRequest(url: endpoint)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json",
            "AccessToken": EnvironmentVariables.apiAccessToken
        ]
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            let stores = handleResponse(data: data, response: response)
            return stores
        } catch {
            throw error
        }
    }
}

struct StoreWrapper: Hashable, Codable {
    var data: [Store]
    var status: String
}

struct Store: Hashable, Codable, Identifiable {
    var id: String
    var name: String
    var zipcode: String
    var address: String
    var pref_code: String
    var latitude: CGFloat
    var longitude: CGFloat
}

extension Store {
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

extension Store {
    static let sampleData: [Store] =
    [
        Store(id: "045512", name: "シエスタハコダテ", zipcode: "0400011", address: "北海道函館市函館本町24-1 シエスタハコダテ 1~3F", pref_code: "01", latitude: 41.7895949, longitude: 140.7519594),
        Store(id: "045264", name: "札幌ステラプレイス", zipcode: "0600005", address: "北海道札幌市中央区北5条西2丁目5番地 札幌ステラプレイスイースト 6F", pref_code: "01", latitude: 43.0681393, longitude: 141.3524285)
    ]
}
