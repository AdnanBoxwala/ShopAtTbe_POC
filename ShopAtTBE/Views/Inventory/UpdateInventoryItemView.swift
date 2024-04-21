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
    @Environment(\.dismiss) var dismiss
    
    @State private var record: Product
    @State private var isUpdating = false
        
    // TODO: go back to previous view
    var body: some View {
        ZStack {
            VStack {
                ProductFormView(record: record)
                    .opacity(isUpdating || viewModel.isUploaded ? 0.5 : 1)
                
                Button("Remove from Database", role: .destructive) {
                    viewModel.removeRecord(record.recordId)
                }
                .padding(.vertical)
                .buttonStyle(BorderedProminentButtonStyle())
            }
            
            ProgressView("Updating product details in Database")
                .opacity(isUpdating ? 1.0 : 0)
            
            UploadSuccessView()
                .opacity(viewModel.isUploaded ? 1.0 : 0)
                .animation(.easeIn, value: viewModel.isUploaded)
                .onChange(of: viewModel.isUploaded) { _, newValue in
                    if newValue == true {
                        isUpdating = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            viewModel.isUploaded = false
                            dismiss()
                        }
                    }
                }
        }
        .navigationTitle(record.productId)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                // TODO: disable button if nothing changed
                Button("Update") {
                    isUpdating = true
                    // update exisitng product in iCloud database
                    Task {
                        viewModel.updateRecord(record)
                    }
                }
            }
        }
    }
    
    init(record: Product) {
        self.record = .init()
        self.record.assets = record.assets
        self.record.category = record.category
        self.record.description = record.description
        self.record.name = record.name
        self.record.price = record.price
        self.record.productId = record.productId
        self.record.quantity = record.quantity
        self.record.recordId = record.recordId
    }
}

#Preview {
    UpdateInventoryItemView(record: .init())
        .environment(ManageInventoryView.ViewModel())
}
