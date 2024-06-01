//
//  HomeView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 14.02.24.
//

import SwiftUI

struct CatalogView: View {
    @Environment(CatalogView.ViewModel.self) var viewModel
    
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
            .onAppear {
                if viewModel.items.isEmpty {
                    viewModel.getAllItems()
                }
            }
            .onOpenURL { productUrl in
                viewModel.handleUrl(productUrl)
            }
            .navigationDestination(item: getProduct()) { item in
                ProductDetailView(item: item)
            }
        }
    }
    
    func getProduct() -> Binding<Product?> {
        return Binding(get: { viewModel.sharedProduct}, set: { viewModel.sharedProduct = $0 })
    }
}

#Preview {
    CatalogView()
        .environment(CatalogView.ViewModel())
        .environment(CustomerView.ViewModel())
}
