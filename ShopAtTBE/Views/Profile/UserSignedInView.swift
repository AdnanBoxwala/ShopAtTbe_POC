//
//  UserSignedInView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 30.05.24.
//

import SwiftUI

struct UserSignedInView: View {
    @Environment(AuthViewModel.self) var authViewModel
    let user: User
    
    @State private var authFailed = false
    @State private var alertTitle = ""
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Button {
                        
                    } label: {
                        VStack(alignment: .leading) {
                            Text("\(user.firstName.capitalized) \(user.lastName.capitalized)")
                                .font(.title2)
                                .foregroundStyle(Color.primary)
                            
                            Text("\(user.emailId)")
                                .font(.caption)
                        }
                    }
                }
                
                Section {
                    NavigationLink("Details") {
                        Text("show user details")
                    }
                    NavigationLink("Order History") {
                        Text("show users transactions")
                    }
                }
                
                Section {
                    HStack {
                        Spacer()
                        Button(role: .destructive) {
                            do {
                                try authViewModel.signOut()
                            } catch {
                                alertTitle = "Sign out failed."
                                authFailed = true
                            }
                        } label: {
                            HStack {
                                Text("Log Out")
                                    .foregroundStyle(Color.white)
                            }
                        }
                        .buttonStyle(BorderedProminentButtonStyle())
                        Spacer()
                    }
                    .listRowBackground(Color.clear)
                }
            }
            .alert(alertTitle, isPresented: $authFailed) {
                Button("Cancel") {
                    authFailed = false
                }
            }
        }
    }
}

#Preview {
    UserSignedInView(user: User.MOCK_USER)
        .environment(AuthViewModel())
}
