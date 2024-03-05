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
        
    @State private var selectedJewellery: JewelleryType = .all
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Spacer()
                    Picker(selection: $selectedJewellery) {
                        ForEach(JewelleryType.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    } label: {
                        Label("filter", systemImage: "binoculars.fill")
                    }
                }
                
                ScrollView {
                    LazyVGrid(columns: columns) {
                        NavigationLink {
                            ProductDetailView()
                        } label: {
                            ProductView()
                        }
                    }
                }
            }
            .navigationTitle("The Butterfly Effect")
            .onAppear(perform: viewModel.getAllItems)
        }
    }
}

#Preview {
    HomeView()
}
