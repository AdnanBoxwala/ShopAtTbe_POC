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
    @State private var deleteRecord = false
        
    // TODO: go back to previous view
    var body: some View {
        @Bindable var viewModel = viewModel
        ZStack {
            ProductFormView(record: record)
                .opacity(isUpdating || viewModel.uploadSuccess ? 0.5 : 1)
            
            if isUpdating && !viewModel.uploadFailure {
                ProgressView("Updating product details in Database")
            }
            
            if viewModel.uploadSuccess {
                UploadSuccessView()
                    .animation(.easeIn(duration: 1), value: viewModel.uploadSuccess)
                    .onAppear {
                        isUpdating = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            viewModel.uploadSuccess = false
                            dismiss()
                        }
                    }
            }
        }
        .alert("Failed!", isPresented: $viewModel.uploadFailure) {
            Button("Retry") {
                isUpdating = false
            }
            Button("Cancel", role: .cancel) {
                isUpdating = false
                dismiss()
            }
        } message: {
            Text("Could not update product details. Please try again.")
        }
        .alert("Remove product", isPresented: $deleteRecord) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                viewModel.removeRecord(record.recordId)
            }
        } message: {
            Text("Are you sure you want to remove \(record.name) from inventory?")
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(record.productId)
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                // TODO: disable button if nothing changed
                Button("Update") {
                    isUpdating = true
                    // update exisitng product in inventory
                    Task {
                        viewModel.updateRecord(record)
                    }
                }
            }
            
            ToolbarItemGroup(placement: .bottomBar) {
                Button("Remove", role: .destructive) {
                    deleteRecord = true
                }
                .buttonStyle(BorderedButtonStyle())
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
