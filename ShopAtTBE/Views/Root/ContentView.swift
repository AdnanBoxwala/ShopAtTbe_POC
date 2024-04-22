//
//  ContentView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 12.03.24.
//

import SwiftUI

struct ContentView: View {
    let butterflyEffectUser: User
    let isAnonymous: Bool
    
    var body: some View {
        switch butterflyEffectUser.role {
        case .admin:
            AdminView(user: butterflyEffectUser)
        case .customer:
            CustomerView(user: butterflyEffectUser, isAnonymous: isAnonymous)
        }
    }
}

#Preview {
    ContentView(butterflyEffectUser: User.MOCK_USER, isAnonymous: false)
        .environment(AuthViewModel())
}
