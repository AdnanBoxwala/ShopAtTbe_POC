//
//  CustomerView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 12.03.24.
//

import SwiftUI

struct CustomerView: View {
    var body: some View {
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

#Preview {
    CustomerView()
}
