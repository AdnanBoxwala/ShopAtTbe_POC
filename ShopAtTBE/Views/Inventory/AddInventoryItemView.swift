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
    
    @State private var newRecord: ManageInventoryView.FetchedRecord = .init(name: "", price: 0.0, assets: [], description: "", productId: "", quantity: 1, category: .all, recordId: CKRecord.ID.init(recordName: "newRecord"))
            
    var body: some View {
        @Bindable var viewModel = viewModel
        ZStack {
            VStack {
                ProductFormView(record: $newRecord)
            }
                .opacity((viewModel.isUploading) ? 0.5 : 1)
            
            if viewModel.isUploading {
                ProgressView("Uploading your product")
            }
            
            if viewModel.isUploaded {
                UploadSuccessView()
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button("Upload") {
                    // save to iCloud
                    Task {
                        viewModel.uploadToDatabase(name: newRecord.name,
                                                   category: newRecord.category,
                                                   productId: newRecord.productId,
                                                   price: newRecord.price,
                                                   quantity: newRecord.quantity,
                                                   description: newRecord.description,
                                                   assets: newRecord.assets)
                    }
                }
                .disabled(newRecord.name.trimmingCharacters(in: .whitespaces).isEmpty || newRecord.productId.trimmingCharacters(in: .whitespaces).isEmpty || newRecord.assets.isEmpty)
            }
        }
    }
}

#Preview {
    AddInventoryItemView()
        .environment(ManageInventoryView.ViewModel())
}
