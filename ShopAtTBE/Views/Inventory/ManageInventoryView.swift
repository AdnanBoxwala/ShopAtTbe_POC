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
    @State private var showUserProfileSheet = false
    
    let user: User
    let isAnonymous: Bool
    
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
            .sheet(isPresented: $showUserProfileSheet) {
                UserProfileSheetView(user: user, isAnonymous: isAnonymous)
            }
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button {
                        showAddItemSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }                    
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showUserProfileSheet.toggle()
                    } label: {
                        Label("Profile", systemImage: "person.crop.circle")
                    }
                }
            }
        }
//        .addSideBar(using: AnyView(SideBarMenuView()))
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
    ManageInventoryView(user: User.MOCK_ADMIN, isAnonymous: false)
        .environment(ManageInventoryView.ViewModel())
}
