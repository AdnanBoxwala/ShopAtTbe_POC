//
//  HomeView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 14.02.24.
//

import SwiftUI

struct CatalogView: View {
    @State var viewModel = ViewModel()
    
    @State private var linkedProduct: Product?    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Spacer()
                    Picker(selection: $viewModel.selectedJewellery) {
                        ForEach(JewelleryType.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    } label: {
                        Label("filter", systemImage: "binoculars.fill")
                    }
                }
                
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(viewModel.items) { item in
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
                .padding(.horizontal)
            }
            .navigationTitle("Catalog")
            .onAppear(perform: viewModel.getAllItems)
            .onOpenURL { productUrl in
                linkedProduct = viewModel.handleUrl(productUrl)
            }
            .navigationDestination(item: $linkedProduct) { item in
                ProductDetailView(item: item)
            }
        }
    }
}

#Preview {
    CatalogView()
}
