//
//  CustomerView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 12.03.24.
//

import SwiftUI

struct CustomerView: View {
    @State var customerViewModel = ViewModel()
    let user: ButterflyEffect.User
    let isAnonymous: Bool
    
    var body: some View {
        TabView {
            HomeView(selectedJewellery: $customerViewModel.selectedJewellery)
                .tabItem { Label("T.B.E", systemImage: "house") }
            CheckoutView(basket: customerViewModel.basket)
                .tabItem { Label("Bag", systemImage: "handbag.fill") }
            UserProfileView(user: user, isAnonymous: isAnonymous)
                .tabItem { Label("Profile", systemImage: "person.circle.fill") }
        }
        .environment(customerViewModel)
    }
}

#Preview {
    CustomerView(user: ButterflyEffect.MOCK_USER, isAnonymous: false)
        .environment(AuthViewModel())
}
