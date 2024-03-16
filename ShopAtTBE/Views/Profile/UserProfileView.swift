//
//  UserProfileView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 10.03.24.
//

import SwiftUI

struct UserProfileView: View {
    @Environment(AuthViewModel.self) var authViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                if authViewModel.loggedInUser != nil && authViewModel.currentUser != nil {
                    VStack(spacing: 10) {
                        Text(authViewModel.currentUser!.initials)
                            .font(.title)
                            .padding()
                            .background(Color.secondary)
                            .clipShape(Circle())
                        
                        Text("\(authViewModel.currentUser!.firstName) \(authViewModel.currentUser!.lastName)")
                        
                        if !authViewModel.loggedInUser!.isAnonymous {
                            Button("Sign Out", role: .destructive) {
                                authViewModel.signOut()
                            }
                        } else {
                            NavigationLink {
                                LoginView()
                            } label: {
                                Text("Sign In")
                            }
                        }
                    }
                    
                    if !authViewModel.loggedInUser!.isAnonymous {
                        HStack {
                            Button {
                                print("show users orders")
                            } label: {
                                Text("See orders")
                                    .foregroundStyle(Color.white)
                                    .padding()
                                    .background(.blue)
                                    .clipShape(Capsule())
                            }
                            Spacer()
                        }
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    UserProfileView()
        .environment(AuthViewModel())
}
