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
    let isAnonymous: Bool
    
    var body: some View {
        TabView {
            ManageInventoryView(user: user, isAnonymous: isAnonymous)
                .tabItem { Label("Inventory", systemImage: "archivebox.fill")}
        }
        .environment(viewModel)
    }
}

#Preview {
    AdminView(user: User.MOCK_ADMIN, isAnonymous: false)
        .environment(AuthViewModel())
}
