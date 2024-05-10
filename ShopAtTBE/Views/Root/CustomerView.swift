//
//  CustomerView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 12.03.24.
//

import SwiftUI

struct CustomerView: View {
    @Environment(AuthViewModel.self) var authViewModel
    @State private var customerViewModel = CustomerView.ViewModel()
    @State private var showUserProfileSheet = false
    
    let user: User
    let isAnonymous: Bool

    var body: some View {
        NavigationStack {
            CatalogView()
                .sheet(isPresented: $showUserProfileSheet) {
                    UserProfileSheetView(user: user, isAnonymous: isAnonymous)
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
                                    Text("\(customerViewModel.totalItemCount)")
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
        .environment(customerViewModel)
    }
}

#Preview {
    CustomerView(user: User.MOCK_USER, isAnonymous: false)
        .environment(AuthViewModel())
        .environment(CustomerView.ViewModel())
}
