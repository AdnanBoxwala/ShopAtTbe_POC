//
//  HomeView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 14.02.24.
//

import SwiftUI

struct CatalogView: View {
    @State var viewModel = ViewModel()
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(viewModel.items.filter(viewModel.showSelectedJewellery)) { item in
                            NavigationLink {
                                ProductDetailView(item: item)
                            } label: {
                                VStack{
                                    ProductView(
                                        image: item.displayImage ?? UIImage(named: "placeholder_tbe")!,
                                        name: item.name,
                                        price: item.price)
                                    Spacer()
                                }
                            }
                        }
                    }
                }
                .padding([.horizontal, .top])
            }
            .navigationTitle("Catalog")
            .addSideBar(using: AnyView(SideBarMenuView()))
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
                    Picker(selection: $viewModel.selectedJewellery) {
                        ForEach(JewelleryType.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    } label: {
                        Image(systemName: "binoculars.fill")
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
