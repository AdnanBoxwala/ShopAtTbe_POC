//
//  ProductListView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 14.04.24.
//

import SwiftUI

struct ProductListView: View {
    @State var viewModel = CatalogView.ViewModel()
    
    @State private var searchText = ""
    @State private var showAddItemSheet = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(JewelleryType.allCases, id: \.self) { category in
                    Section {
                        ForEach(searchResults.filter { $0.category == category }) { item in
                            NavigationLink {
                                UpdateInventoryItemView()
                            } label: {
                                Text(item.productId)
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
    }
    
    var searchResults: [Product] {
        if searchText.isEmpty {
            return viewModel.items
        } else {
            return viewModel.items.filter {
                $0.name.lowercased().contains(searchText.lowercased()) ||
                $0.productId.lowercased().contains(searchText.lowercased()) ||
                $0.description.lowercased().contains(searchText.lowercased())
            }
        }
    }
}

#Preview {
    ProductListView()
}
