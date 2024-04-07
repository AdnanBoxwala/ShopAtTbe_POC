//
//  CustomerView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 12.03.24.
//

import SwiftUI

struct CustomerView: View {
    @State var viewModel = ViewModel()
    let user: ButterflyEffect.User
    let isAnonymous: Bool
    
    var body: some View {
        TabView {
            CatalogView()
                .tabItem { Label("T.B.E", systemImage: "house") }
            BasketView()
                .tabItem { Label("Bag", systemImage: "handbag.fill") }
            ProfileView(user: user, isAnonymous: isAnonymous)
                .tabItem { Label("Profile", systemImage: "person.circle.fill") }
        }
        .environment(viewModel)
    }
}

#Preview {
    CustomerView(user: ButterflyEffect.MOCK_USER, isAnonymous: false)
        .environment(AuthViewModel())
}
