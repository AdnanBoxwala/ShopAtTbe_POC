//
//  ContentView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 14.02.24.
//

import CloudKit
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dummyUser: User
    
    var body: some View {        
        if dummyUser.role == .admin {
            TabView {
                HomeView()
                    .tabItem { Label("T.B.E", systemImage: "house") }
                UpdateInventoryView()
                    .tabItem { Label("Update Inventory", systemImage: "archivebox.fill")}
            }
        } else if dummyUser.role == .customer {
            TabView {
                HomeView()
                    .tabItem { Label("T.B.E", systemImage: "house") }
                CheckoutView()
                    .tabItem { Label("Bag", systemImage: "handbag.fill") }
                UserProfileView()
                    .tabItem { Label("Profile", systemImage: "person.circle.fill") }
            }
        }
    }
}

#Preview {
    ContentView()
}
