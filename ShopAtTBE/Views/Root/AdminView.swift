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
            ProductListView()
                .tabItem { Label("Inventory", systemImage: "archivebox.fill")}
//            UpdateInventoryView()
//                .tabItem { Label("Update Inventory", systemImage: "pencil")}
            ProfileView(user: user)
                .tabItem { Label("Profile", systemImage: "person.circle.fill") }
        }
    }
}

#Preview {
    AdminView(user: ButterflyEffect.MOCK_ADMIN)
        .environment(AuthViewModel())
}
