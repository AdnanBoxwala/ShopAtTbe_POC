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
        ZStack(alignment: .bottom) {
            Form {
                Section {
                    TextField("Name", text: $viewModel.product.name)
                        .focused($editorIsFocussed)
                        .textInputAutocapitalization(.words)
                    
                    Picker("Jewellery type", selection: $viewModel.product.type) {
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
                
                TextField("Price", value: $viewModel.product.price, formatter: Product.currencyFormatter)
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
                            ForEach(0..<viewModel.selectedImages.count, id: \.self) { idx in
                                // TODO:
                                // index out of range error.
                                viewModel.selectedImages[idx]
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 75, height: 75)
                                    .clipped()
                            }
                            .disabled(viewModel.selectedImages.count == 0)
                        }
                    }
                } header: {
                    Text("Add images or videos")
                }
                .listRowSeparator(.hidden)
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
                    viewModel.saveToCloud()
                }
                .disabled(viewModel.product.isEntryValid)
            }
        }
    }
}

#Preview {
    AddInventoryItemView()
}
