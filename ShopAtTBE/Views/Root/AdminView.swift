//
//  AdminView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 12.03.24.
//

import SwiftUI

struct AdminView: View {
    @State var viewModel = ManageInventoryView.ViewModel()
    let user: User
    
    var body: some View {
        TabView {
            ManageInventoryView()
                .tabItem { Label("Inventory", systemImage: "archivebox.fill")}
            ProfileView(user: user)
                .tabItem { Label("Profile", systemImage: "person.circle.fill") }
        }
        .environment(viewModel)
    }
}

#Preview {
    AdminView(user: User.MOCK_ADMIN)
        .environment(AuthViewModel())
}
