//
//  CheckoutView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 14.02.24.
//

import SwiftUI

struct BasketView: View {
    @Environment(CustomerView.ViewModel.self) var customerViewModel
    
    var body: some View {
        NavigationStack {
            if customerViewModel.basket.isEmpty {
                ContentUnavailableView("", systemImage: "handbag", description: Text("Your Bag is Empty.\nWhen you add products, they'll\nappear here."))
            } else {
                VStack {
                    List {
                        ForEach(customerViewModel.basket, id: \.productId) { basketItem in
                            BasketItemView(item: basketItem)
                        }
                        .onDelete(perform: customerViewModel.removeBasketItem)
                        
                        HStack {
                            Text("Total: ")
                                .font(.title2)
                            Spacer()
                            Text(customerViewModel.totalCost, format: .currency(code: "AED"))
                                .font(.title2)
                        }
                    }
                }
                .navigationTitle("Basket")
            }
        }
    }
    
    
}

#Preview {
    BasketView()
        .environment(CustomerView.ViewModel())
}
