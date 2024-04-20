//
//  UpdateInventoryItemView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 24.02.24.
//

import CloudKit
import SwiftUI

struct UpdateInventoryItemView: View {
    @Environment(ManageInventoryView.ViewModel.self) var viewModel
    @State var record: ManageInventoryView.ProductRecord
        
    // TODO: go back to previous view
    var body: some View {
        VStack {
            ProductFormView(record: $record)
            
            Button("Delete", role: .destructive) {
                viewModel.removeRecord(record.recordId)
            }
            .padding()
            .background(Color.red)
            .foregroundStyle(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 5))
        }
        .navigationTitle(record.productId)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button("Update") {
                    // save to iCloud
                    Task {
                        viewModel.updateRecord(record)
                    }
                }
                .disabled(record.name.trimmingCharacters(in: .whitespaces).isEmpty || record.productId.trimmingCharacters(in: .whitespaces).isEmpty || record.assets.isEmpty)
            }
        }

    }
    
    init(record: ManageInventoryView.ProductRecord) {
        self.record = .init(name: record.name,
                            price: record.price,
                            assets: record.assets,
                            description: record.description,
                            productId: record.productId,
                            quantity: record.quantity,
                            category: record.category,
                            recordId: record.recordId)
    }
}

#Preview {
    UpdateInventoryItemView(record: .init())
        .environment(ManageInventoryView.ViewModel())
}
