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
        if authViewModel.butterflyEffectUser != nil {
            switch authViewModel.butterflyEffectUser!.role {
            case .admin:
                AdminView()
            case .customer:
                CustomerView()
            }
        } else {
            LoginView()
        }
    }
}

#Preview {
    ContentView()
}
