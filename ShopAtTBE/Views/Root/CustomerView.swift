//
//  CustomerView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 12.03.24.
//

import SwiftUI

struct CustomerView: View {
    @State var viewModel = ViewModel()
    var body: some View {
        TabView {
            HomeView(selectedJewellery: $viewModel.selectedJewellery)
                .tabItem { Label("T.B.E", systemImage: "house") }
            CheckoutView()
                .tabItem { Label("Bag", systemImage: "handbag.fill") }
            UserProfileView()
                .tabItem { Label("Profile", systemImage: "person.circle.fill") }
        }
        .onAppear(perform: viewModel.getAllItems)
        .environment(viewModel)
    }
}

#Preview {
    CustomerView()
}
