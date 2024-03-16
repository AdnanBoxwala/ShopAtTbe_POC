//
//  ContentView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 12.03.24.
//

import SwiftUI

struct ContentView: View {
    @Environment(AuthViewModel.self) var authViewModel
    
    var body: some View {
        if authViewModel.loggedInUser != nil {
            switch authViewModel.loggedInUser!.isAnonymous {
            case true:
                CustomerView()
            case false:
                if authViewModel.currentUser != nil {
                    switch authViewModel.currentUser!.role {
                    case .admin:
                        AdminView()
                    case .customer:
                        CustomerView()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
