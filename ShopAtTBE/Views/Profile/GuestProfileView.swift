//
//  GuestProfileView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 01.04.24.
//

import SwiftUI

struct GuestProfileView: View {
    let user: ButterflyEffect.User
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                Text(user.initials)
                    .font(.title)
                    .padding()
                    .background(Color.secondary)
                    .clipShape(Circle())
                
                Text("\(user.firstName.uppercased()) \(user.lastName.uppercased())")
                
                Spacer()
                
                NavigationLink {
                    LoginView()
                } label: {
                    Text("Sign In with Email")
                        .foregroundStyle(.primary)
                }
            }
            .padding()
        }
    }
}

#Preview {
    GuestProfileView(user: ButterflyEffect.MOCK_USER)
        .environment(AuthViewModel())
}
