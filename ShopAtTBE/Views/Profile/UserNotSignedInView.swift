//
//  UserNotLoggedInView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 30.05.24.
//

import SwiftUI

struct UserNotSignedInView: View {
    @State private var showSignInSheet = false
    
    var body: some View {
        NavigationStack {
            VStack {
                TbeButton(title: "Log in to account") {
                    showSignInSheet.toggle()
                }
                .padding()
                Spacer()
            }
            .sheet(isPresented: $showSignInSheet) {
                LoginView()
            }
        }
    }
}

#Preview {
    UserNotSignedInView()
        .environment(AuthViewModel())
}
