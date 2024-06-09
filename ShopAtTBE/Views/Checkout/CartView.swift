//
//  CartView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 14.02.24.
//

import PassKit
import SwiftUI

struct CartView: View {
    @Environment(CustomerView.ViewModel.self) var customerViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                if customerViewModel.paymentSuccess {
                    Text("Thanks for your purchase.")
                } else {
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
                        
                        Spacer()
                        
                        //                PayWithApplePayButton(.checkout) {
                        //                    // make payment
                        //                }
                        //                .frame(width: 250, height: 50)
                        //                .payWithApplePayButtonStyle(.automatic)
                        PaymentButton(action: customerViewModel.pay)
                            .padding(.horizontal)
                    }
                    
                    
                    
                }
                
            }
            .navigationTitle("Cart")
            .onDisappear{
                if customerViewModel.paymentSuccess {
                    customerViewModel.paymentSuccess = false
                }
            }
        }
    }
    
    
}

#Preview {
    CartView()
        .environment(CustomerView.ViewModel())
}
