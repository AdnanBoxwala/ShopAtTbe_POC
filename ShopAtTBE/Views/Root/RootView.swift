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
            if let loggedInUser = authViewModel.loggedInUser, let butterflyEffectUser = authViewModel.butterflyEffectUser {
                ContentView(butterflyEffectUser: butterflyEffectUser, isAnonymous: loggedInUser.isAnonymous)
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
