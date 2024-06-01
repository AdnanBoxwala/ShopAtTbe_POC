//
//  RootView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 14.02.24.
//

import SwiftUI

struct RootView: View {
    @State var authViewModel = AuthViewModel()
    @State var catalogViewViewModel = CatalogView.ViewModel()
    @State var customerViewViewModel = CustomerView.ViewModel()
    @State var manageInventoryViewViewModel = ManageInventoryView.ViewModel()
    
    @State private var showStartAnimation = true
    @State private var scaleAmount = 1.0
    
    var body: some View {
        Group {
            if showStartAnimation {
                Color("Background")
                    .ignoresSafeArea()
                    .overlay {
                        Image(.placeholderTbe)
                            .scaleEffect(scaleAmount)
                            .animation(.easeIn(duration: 1), value: scaleAmount)
                    }
            } else {
                switch authViewModel.userRole {
                case .admin:
                    AdminView(user: authViewModel.butterflyEffectUser!)
                case .customer:
                    CustomerView()
                }
            }
        }
        .onAppear {
            scaleAmount = 2.0
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                showStartAnimation = false
            }
        }
        .environment(authViewModel)
        .environment(catalogViewViewModel)
        .environment(customerViewViewModel)
        .environment(manageInventoryViewViewModel)
    }
}

#Preview {
    RootView()
}
