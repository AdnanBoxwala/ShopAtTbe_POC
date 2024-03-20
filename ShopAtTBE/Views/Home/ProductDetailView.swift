//
//  ProductDetailView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 14.02.24.
//

import SwiftUI

struct ProductDetailView: View {
    @Environment(CustomerView.ViewModel.self) var viewModel
    
    let item: Product
        
    var body: some View {
        // TODO:
        // zstack with add to bucket button on top
        GeometryReader { proxy in
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    TabView {
                        ForEach(item.images, id: \.self) { uiimage in
                            ZStack {
                                NavigationLink {
                                    // TODO:
                                    // allow zoom
                                    // https://www.hackingwithswift.com/quick-start/swiftui/how-to-handle-pinch-to-zoom-for-views
                                    
                                    Image(uiImage: uiimage)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxWidth: .infinity)
                                } label: {
                                    Image(uiImage: uiimage)
                                        .resizable()
                                        .scaledToFit()
                                }
                            }
                        }
                    }
                    .frame(minHeight: proxy.size.height * 0.5)
                    .tabViewStyle(.page)
                    .indexViewStyle(.page(backgroundDisplayMode: .interactive))
                    
                    VStack(alignment: .leading) {
                        
                        Text(item.category.rawValue)
                            .font(.headline)
                        Text(item.name)
                            .font(.title)
                        Text(item.price, format: .currency(code: "AED"))
                            .font(.title3)
                        
                        
                        Text(item.description)
                    }
                    
                    Button {
                        viewModel.addToBasket(item: item, quantity: 1)
                    } label: {
                        Text("Add to Bag")
                            .font(.title2)
                            .foregroundStyle(Color.primary)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.secondary)
                            .clipShape(Capsule())
                    }
                }
            }
            .padding(.horizontal)
            .navigationTitle(item.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ProductDetailView(item: Product())
}
