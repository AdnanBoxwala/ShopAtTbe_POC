//
//  ProductFormView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 17.04.24.
//

import CloudKit
import _PhotosUI_SwiftUI
import SwiftUI

struct ProductFormView: View {
    @Environment(ManageInventoryView.ViewModel.self) var viewModel
    @Binding var record: ManageInventoryView.ProductRecord
    
    @FocusState private var editorIsFocussed: Bool
    @State var selectedItems: [PhotosPickerItem] = []
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $record.name)
                    .focused($editorIsFocussed)
                    .textInputAutocapitalization(.words)
                
                Picker("Jewellery type", selection: $record.category) {
                    ForEach(JewelleryType.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                
                TextField("Product ID", text: $record.productId)
                    .focused($editorIsFocussed)
                    .textInputAutocapitalization(.characters)
                    .autocorrectionDisabled()
            } header: {
                Text("Product details")
            }
            
            // TODO: needs to be fixed
            TextField("Price", value: $record.price, formatter: currencyFormatter)
                .keyboardType(.decimalPad)
                .focused($editorIsFocussed)
            
            Picker("Quantity", selection: $record.quantity) {
                ForEach(0..<11, id: \.self) {
                    Text("\($0)")
                }
            }
            
            Section {
                TextField("Enter here...", text: $record.description, axis: .vertical)
                    .lineLimit(5)
                    .focused($editorIsFocussed)
                    .textInputAutocapitalization(.sentences)
                    .autocorrectionDisabled(false)
            } header: {
                Text("Description")
            }
            
            Section {
                PhotosPicker("Search in Photos", selection: $selectedItems, maxSelectionCount: 3, matching: .any(of: [.images, .screenshots]))
                assetsPreview()
            } header: {
                Text("Add images")
            }
            .onChange(of: selectedItems) {
                Task {
                    record.assets.removeAll()
                    for item in selectedItems {
                        if let ckAsset = await item.toCkAsset() {
                            record.assets.append(ckAsset)
                        }
                    }
                }
            }
            .listRowSeparator(.hidden)
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    editorIsFocussed = false
                }
            }
        }
    }
    
    
    func assetsPreview() -> some View {
        var assetImages: [UIImage] = []
        
        for asset in record.assets {
            if let uiimage = asset.toUiImage() {
                assetImages.append(uiimage)
            }
        }
        
        return ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<assetImages.count, id: \.self) { idx in
                    Image(uiImage: assetImages[idx])
                        .resizable()
                        .scaledToFill()
                        .frame(width: 75, height: 75)
                        .clipped()
                }
            }
        }
    }
}



#Preview {
    ProductFormView(record: .constant(.init()))
        .environment(ManageInventoryView.ViewModel())
}
