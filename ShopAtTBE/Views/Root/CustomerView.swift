//
//  CustomerView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 12.03.24.
//

import SwiftUI

struct CustomerView: View {
    @State var viewModel = ViewModel()
    @State private var selectedTab = "Catalog"
    
    let user: ButterflyEffect.User
    let isAnonymous: Bool
    
    var body: some View {
        TabView(selection: $selectedTab) {
            CatalogView()
                .tabItem { Label("T.B.E", systemImage: "house") }
                .tag("Catalog")
            BasketView()
                .tabItem { Label("Bag", systemImage: "handbag.fill") }
                .tag("Basket")
            ProfileView(user: user, isAnonymous: isAnonymous)
                .tabItem { Label("Profile", systemImage: "person.circle.fill") }
                .tag("Profile")
        }
        .environment(viewModel)
        .onOpenURL(perform: { url in
            if viewModel.isValidUrlScheme(url) {
                selectedTab = "Catalog"
            }
        })
    }
}

#Preview {
    CustomerView(user: ButterflyEffect.MOCK_USER, isAnonymous: false)
        .environment(AuthViewModel())
}
