//
//  CheckoutView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 14.02.24.
//

import SwiftUI

struct CheckoutView: View {
    var body: some View {
        ContentUnavailableView("", systemImage: "handbag", description: Text("Your Bag is Empty.\nWhen you add products, they'll\nappear here."))
    }
}

#Preview {
    CheckoutView()
}
