//
//  RootView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 14.02.24.
//

import SwiftUI

struct RootView: View {
    @State var authViewModel = AuthViewModel()
    
    var body: some View {
        Group {
            if authViewModel.loggedInUser != nil {
                ContentView()
            } else {
                LoginView()
            }
        }
        .environment(authViewModel)
    }
}

#Preview {
    RootView()
}
