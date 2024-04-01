//
//  AdminView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 12.03.24.
//

import SwiftUI

struct AdminView: View {
    let user: ButterflyEffect.User
    
    var body: some View {
        TabView {
//            HomeView()
//                .tabItem { Label("T.B.E", systemImage: "house") }
            UpdateInventoryView()
                .tabItem { Label("Update Inventory", systemImage: "archivebox.fill")}
            ProfileView(user: user)
                .tabItem { Label("Profile", systemImage: "person.circle.fill") }
        }
    }
}

#Preview {
    AdminView(user: ButterflyEffect.MOCK_ADMIN)
        .environment(AuthViewModel())
}
