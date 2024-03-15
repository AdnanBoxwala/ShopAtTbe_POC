//
//  HomeView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 14.02.24.
//

import SwiftUI

struct HomeView: View {
    @State private var viewModel = ViewModel()
    
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
                                        image: item.displayImage,
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
            .navigationTitle("The Butterfly Effect")
            .onAppear(perform: viewModel.getAllItems)
        }
    }
}

#Preview {
    HomeView()
}
