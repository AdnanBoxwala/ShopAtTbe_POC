//
//  AddInventoryItemView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 24.02.24.
//

import CloudKit
import PhotosUI
import SwiftUI

struct AddInventoryItemView: View {
    @Environment(ManageInventoryView.ViewModel.self) var viewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var product: Product = .init()
    @State private var isUploading = false
    @State private var showFailureAlert = false
    
    var body: some View {
        @Bindable var viewModel = viewModel
        ZStack {
            ProductFormView(record: product)
                .opacity(isUploading || viewModel.uploadSuccess ? 0.5 : 1)
            
            if isUploading && !viewModel.uploadFailure {
                ProgressView("Adding new product to Database")
            }
            
            if viewModel.uploadSuccess {
                UploadSuccessView()
                    .animation(.easeIn(duration: 1), value: viewModel.uploadSuccess)
                    .onAppear {
                        isUploading = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            viewModel.uploadSuccess = false
                            product = .init()
                            dismiss()
                        }
                    }
            }
        }
        .alert("Failed!", isPresented: $viewModel.uploadFailure) {
            Button("Retry") {
                isUploading = false
            }
            Button("Cancel", role: .cancel) {
                isUploading = false
                dismiss()
            }
        } message: {
            Text("Could not add product to inventory. Please try again.")
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("New Product")
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button("Add") {
                    isUploading = true
                    // save new product to iCloud database
                    viewModel.addRecord(product)
                    
                }
                .disabled(product.name.trimmingCharacters(in: .whitespaces).isEmpty || product.productId.trimmingCharacters(in: .whitespaces).isEmpty || product.assets.isEmpty)
            }
        }
    }
}

#Preview {
    AddInventoryItemView()
        .environment(ManageInventoryView.ViewModel())
}
