//
//  AdminView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 12.03.24.
//

import SwiftUI

struct AdminView: View {
    @Environment(AuthViewModel.self) var authViewModel
    @Environment(ManageInventoryView.ViewModel.self) var manageInventoryViewModel
    
    let user: User
    
    var body: some View {
        TabView {
            ManageInventoryView(user: user)
                .tabItem { Label("Inventory", systemImage: "archivebox.fill")}
            Text("test")
                .tabItem { Label("test", systemImage: "house") }
        }
    }
}

#Preview {
    AdminView(user: User.MOCK_ADMIN)
        .environment(AuthViewModel())
}
