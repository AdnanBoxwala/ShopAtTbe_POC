//
//  CustomerView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 12.03.24.
//

import SwiftUI

struct CustomerView: View {
    @Environment(CustomerView.ViewModel.self) var viewModel
    @State private var showUserProfileSheet = false

    var body: some View {
        NavigationStack {
            CatalogView()
                .sheet(isPresented: $showUserProfileSheet) {
                    UserProfileSheetView()
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink {
                            CartView()
                        } label: {
                            Image(systemName: "handbag")
                                .padding(.top, 8)
                                .padding(.trailing, 5)
                                .overlay(alignment: .topTrailing) {
                                    Text("\(viewModel.totalItemCount)")
                                        .font(.caption)
                                }
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
    }
}

#Preview {
    CustomerView()
        .environment(AuthViewModel())
        .environment(CustomerView.ViewModel())
}
