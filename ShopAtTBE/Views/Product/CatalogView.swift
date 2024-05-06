//
//  HomeView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 14.02.24.
//

import SwiftUI

struct CatalogView: View {
    @State var viewModel = ViewModel()
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationStack {
            ScrollableTabBar(activeTab: JewelleryType.bangles) { type in
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 30) {
                        ForEach(viewModel.items.filter { $0.category == type }) { item in
                            NavigationLink {
                                ProductDetailView(item: item)
                            } label: {
                                ProductView(
                                    image: item.displayImage ?? UIImage(named: "placeholder_tbe")!,
                                    name: item.name,
                                    price: item.price)
                            }
                        }
                    }
                }
                .padding(.top)
            }
            .navigationTitle("Catalog")
//            .addSideBar(using: AnyView(SideBarMenuView()))
            .onAppear {
                if viewModel.items.isEmpty {
                    viewModel.getAllItems()
                }
            }
            .onOpenURL { productUrl in
                viewModel.handleUrl(productUrl)
            }
            .navigationDestination(item: $viewModel.sharedProduct) { item in
                ProductDetailView(item: item)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        BagView()
                    } label: {
                        Label("Cart", systemImage: "cart")
                    }
                }
            }
        }
    }
}

#Preview {
    CatalogView()
        .environment(CustomerView.ViewModel())
        .environment(AuthViewModel())
}
