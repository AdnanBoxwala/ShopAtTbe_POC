//
//  UpdateInventoryView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 14.04.24.
//

import SwiftUI

struct UpdateInventoryView: View {
    @Environment(UpdateInventoryView.ViewModel.self) var viewModel
    
    @State private var searchText = ""
    @State private var showAddItemSheet = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(JewelleryType.allCases, id: \.self) { category in
                    Section {
                        ForEach(searchResults.filter { $0.product.category == category }, id: \.product.productId) { item in
                            NavigationLink {
                                UpdateInventoryItemView(queriedProduct: item)
                            } label: {
                                Text(item.product.productId)
                            }
                        }
                    } header: {
                        Text(category.rawValue)
                    }
                    .isHidden(viewModel.isCategoryEmpty(category))
                }
            }
            .navigationTitle("Inventory")
            .sheet(isPresented: $showAddItemSheet) {
                NavigationStack {
                    AddInventoryItemView()
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button {
                        showAddItemSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    
                    EditButton()
                }
                
            }
        }
        .onAppear {
            if viewModel.items.isEmpty {
                viewModel.getAllItems()
            }
        }
        .searchable(text: $searchText)
        .environment(viewModel)
    }
    
    var searchResults: [CKQueriedProduct] {
        if searchText.isEmpty {
            return viewModel.items
        } else {
            return viewModel.items.filter {
                $0.product.name.lowercased().contains(searchText.lowercased()) ||
                $0.product.productId.lowercased().contains(searchText.lowercased()) ||
                $0.product.description.lowercased().contains(searchText.lowercased())
            }
        }
    }
}

#Preview {
    UpdateInventoryView()
        .environment(UpdateInventoryView.ViewModel())
}
