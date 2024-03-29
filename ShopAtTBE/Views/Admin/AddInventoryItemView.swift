//
//  AddInventoryItemView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 24.02.24.
//

import PhotosUI
import SwiftUI

struct AddInventoryItemView: View {
    @FocusState private var editorIsFocussed: Bool
    @State private var viewModel = ViewModel()
        
    var body: some View {
        ZStack {
            Form {
                Section {
                    TextField("Name", text: $viewModel.product.name)
                        .focused($editorIsFocussed)
                        .textInputAutocapitalization(.words)
                    
                    Picker("Jewellery type", selection: $viewModel.product.category) {
                        ForEach(JewelleryType.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    
                    TextField("Product ID", text: $viewModel.product.productId)
                        .focused($editorIsFocussed)
                        .textInputAutocapitalization(.characters)
                        .autocorrectionDisabled()
                } header: {
                    Text("Product details")
                }
                
                TextField("Price", value: $viewModel.product.price, formatter: currencyFormatter)
                    .keyboardType(.decimalPad)
                    .focused($editorIsFocussed)
                
                Picker("Quantity", selection: $viewModel.product.quantity) {
                    ForEach(1..<11, id: \.self) {
                        Text("\($0)")
                    }
                }
                
                Section {
                    TextField("Enter here...", text: $viewModel.product.description, axis: .vertical)
                        .lineLimit(5)
                        .focused($editorIsFocussed)
                        .textInputAutocapitalization(.sentences)
                        .autocorrectionDisabled(false)
                } header: {
                    Text("Description")
                }
                
                Section {
                    PhotosPicker("Search in Photos", selection: $viewModel.photoPickerItems, maxSelectionCount: 3, matching: .any(of: [.images, .screenshots]))
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.imageData, id: \.self) { data in
                                if let uiImage = UIImage(data: data) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 75, height: 75)
                                        .clipped()
                                }
                            }
                            .disabled(viewModel.imageData.isEmpty)
                        }
                    }
                } header: {
                    Text("Add images")
                }
                .listRowSeparator(.hidden)
            }
            .opacity((viewModel.isUploading) ? 0.5 : 1)
            
            if viewModel.isUploading {
                ProgressView("Uploading your product")
            }
            
            if viewModel.isUploaded {
                UploadSuccessView()
            }
        }
        .navigationTitle("New Product")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    editorIsFocussed = false
                }
            }
            
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button("Upload") {
                    // save to iCloud
                    Task {
                        viewModel.saveToCloud()
                    }
                }
                .disabled(viewModel.product.isEntryValid)
            }
        }
    }
}

#Preview {
    AddInventoryItemView()
}
