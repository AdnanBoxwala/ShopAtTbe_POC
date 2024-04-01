//
//  CheckoutView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 14.02.24.
//

import SwiftUI

struct BasketView: View {
    let basket: [BasketItem]
    
    var body: some View {
        if basket.isEmpty {
            ContentUnavailableView("", systemImage: "handbag", description: Text("Your Bag is Empty.\nWhen you add products, they'll\nappear here."))
        } else {
            List(basket, id: \.productId) {
                BasketItemView(item: $0)
            }
        }
    }
}

#Preview {
    BasketView(basket: CustomerView.ViewModel.MOCK_BASKET)
}
