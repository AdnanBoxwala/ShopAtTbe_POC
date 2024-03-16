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
        switch authViewModel.loggedInUser!.isAnonymous {
        case true:
            CustomerView()
        case false:
            switch authViewModel.currentUser!.role {
            case .admin:
                AdminView()
            case .customer:
                CustomerView()
            }
        }
    }
}

#Preview {
    ContentView()
}
