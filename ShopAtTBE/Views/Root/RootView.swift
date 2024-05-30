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
        // TODO: if anonymous user, find solution for next time app is opened
        Group {
            if let loggedInUser = authViewModel.loggedInUser {
                if let butterflyEffectUser = authViewModel.butterflyEffectUser {
                    ContentView(butterflyEffectUser: butterflyEffectUser, isAnonymous: loggedInUser.isAnonymous)
                } else {
                    LoginView()
                }
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
