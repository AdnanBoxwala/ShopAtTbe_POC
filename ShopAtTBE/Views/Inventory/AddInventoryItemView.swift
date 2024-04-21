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
    
    var body: some View {
        ZStack {
            ProductFormView(record: product)
                .opacity(isUploading || viewModel.isUploaded ? 0.5 : 1)
            
            ProgressView("Adding new product to Database")
                .opacity(isUploading ? 1.0 : 0)
            
            UploadSuccessView()
                .opacity(viewModel.isUploaded ? 1.0 : 0)
                .animation(.easeIn, value: viewModel.isUploaded)
                .onChange(of: viewModel.isUploaded) { _, newValue in
                    if newValue == true {
                        isUploading = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            viewModel.isUploaded = false
                            product = .init()
                            dismiss()
                        }
                    }
                }
        }
        .navigationTitle("New Product")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button("Upload") {
                    isUploading = true
                    // save new product to iCloud database
                    viewModel.uploadToDatabase(product)
                    
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
