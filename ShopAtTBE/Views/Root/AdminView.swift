//
//  AdminView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 12.03.24.
//

import SwiftUI

struct AdminView: View {
    @State var viewModel = UpdateInventoryView.ViewModel()
    let user: ButterflyEffect.User
    
    var body: some View {
        TabView {
            UpdateInventoryView()
                .tabItem { Label("Inventory", systemImage: "archivebox.fill")}
            ProfileView(user: user)
                .tabItem { Label("Profile", systemImage: "person.circle.fill") }
        }
        .environment(viewModel)
    }
}

#Preview {
    AdminView(user: ButterflyEffect.MOCK_ADMIN)
        .environment(AuthViewModel())
}
