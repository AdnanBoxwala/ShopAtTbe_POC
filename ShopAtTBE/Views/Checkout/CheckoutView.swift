//
//  CheckoutView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 14.02.24.
//

import SwiftUI

struct CheckoutView: View {
    @Environment(CustomerView.ViewModel.self) var viewModel
    
    var body: some View {
        List(viewModel.basket, id: \.productId) {
            BasketItemView(item: $0)
        }
    }
}

#Preview {
    CheckoutView()
}
