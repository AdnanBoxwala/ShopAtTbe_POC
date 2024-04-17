//
//  UpdateInventoryItemView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 24.02.24.
//

import CloudKit
import SwiftUI

struct UpdateInventoryItemView: View {
    @Environment(UpdateInventoryView.ViewModel.self) var viewModel
    
    let queriedProduct: UpdateInventoryView.CKQueriedProduct
    
    // TODO: go back to previous view
    var body: some View {
        VStack {
            Button("Delete", role: .destructive) {
                viewModel.remove(queriedProduct.recordId)
            }
            .padding()
            .background(Color.red)
            .foregroundStyle(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 5))
        }
        .navigationTitle(queriedProduct.product.productId)
    }
}

#Preview {
    UpdateInventoryItemView(queriedProduct: UpdateInventoryView.CKQueriedProduct(recordId: CKRecord.ID.init(recordName: "Product"), product: Product()))
        .environment(UpdateInventoryView.ViewModel())
}
