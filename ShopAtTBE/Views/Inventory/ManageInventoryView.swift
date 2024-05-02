//
//  UpdateInventoryView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 14.04.24.
//

import CloudKit
import SwiftUI

struct ManageInventoryView: View {
    @Environment(ManageInventoryView.ViewModel.self) var viewModel
    
    @State private var searchText = ""
    @State private var showAddItemSheet = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(JewelleryType.allCases, id: \.self) { category in
                    Section {
                        ForEach(viewModel.items.filter({ $0.category == category }), id: \.productId) { item in
                            NavigationLink {
                                UpdateInventoryItemView(record: item)
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
            .sheet(isPresented: $showAddItemSheet){
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
                }
                
            }
        }
        .addSideBar(using: AnyView(SideBarMenuView()))
        .environment(viewModel)
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
    ManageInventoryView()
        .environment(ManageInventoryView.ViewModel())
}
