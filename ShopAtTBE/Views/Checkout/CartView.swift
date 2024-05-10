//
//  CartView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 14.02.24.
//

import SwiftUI

struct CartView: View {
    @Environment(CustomerView.ViewModel.self) var customerViewModel
    
    var body: some View {
        NavigationStack {
            Group {
                if customerViewModel.bag.isEmpty {
                    ContentUnavailableView("", systemImage: "handbag", description: Text("Your Cart is Empty.\nWhen you add products, they'll\nappear here."))
                } else {
                    VStack {
                        List {
                            ForEach(customerViewModel.bag, id: \.productId) { bagItem in
                                CartItemView(item: bagItem)
                            }
                            .onDelete(perform: customerViewModel.removeCartItem)
                            
                            HStack {
                                Text("Total: ")
                                    .font(.title2)
                                Spacer()
                                Text(customerViewModel.totalCost, format: .currency(code: "AED"))
                                    .font(.title2)
                            }
                        }
                    }
                    .navigationTitle("Cart")
                }
            }
//            .addSideBar(using: AnyView(SideBarMenuView()))
        }
    }
    
    
}

#Preview {
    CartView()
        .environment(CustomerView.ViewModel())
        .environment(AuthViewModel())
}