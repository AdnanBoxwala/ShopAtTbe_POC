//
//  BagView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 14.02.24.
//

import SwiftUI

struct BagView: View {
    @Environment(CustomerView.ViewModel.self) var customerViewModel
    
    var body: some View {
        NavigationStack {
            if customerViewModel.bag.isEmpty {
                ContentUnavailableView("", systemImage: "handbag", description: Text("Your Bag is Empty.\nWhen you add products, they'll\nappear here."))
            } else {
                VStack {
                    List {
                        ForEach(customerViewModel.bag, id: \.productId) { bagItem in
                            BagItemView(item: bagItem)
                        }
                        .onDelete(perform: customerViewModel.removeBagItem)
                        
                        HStack {
                            Text("Total: ")
                                .font(.title2)
                            Spacer()
                            Text(customerViewModel.totalCost, format: .currency(code: "AED"))
                                .font(.title2)
                        }
                    }
                }
                .navigationTitle("Bag")
            }
        }
    }
    
    
}

#Preview {
    BagView()
        .environment(CustomerView.ViewModel())
}
