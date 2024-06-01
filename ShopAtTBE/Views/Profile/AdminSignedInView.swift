//
//  AdminSignedInView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 30.05.24.
//

import SwiftUI

struct AdminSignedInView: View {
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
                            
                            Text("Role: \(user.role.rawValue)")
                                .font(.caption)
                        }
                    }
                }
                
                NavigationLink {
                    CatalogView()
                } label: {
                    Text("View Catalog")
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
    AdminSignedInView(user: User.MOCK_ADMIN)
        .environment(AuthViewModel())
}
