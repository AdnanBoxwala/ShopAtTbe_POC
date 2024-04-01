//
//  AdminProfileView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 01.04.24.
//

import SwiftUI

struct AdminProfileView: View {
    @Environment(AuthViewModel.self) var authViewModel
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
                Text("(\(user.role.rawValue))")
                
                
                Spacer()
                
                Button(role: .destructive) {
                    authViewModel.signOut()
                } label: {
                    Text("Log Out")
                        .padding()
                }
            }
            .padding()
        }
    }
}

#Preview {
    AdminProfileView(user: ButterflyEffect.MOCK_ADMIN)
        .environment(AuthViewModel())
}
