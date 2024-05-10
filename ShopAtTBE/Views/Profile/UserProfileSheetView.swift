//
//  UserProfileSheetView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 06.05.24.
//

import SwiftUI

struct UserProfileSheetView: View {
    @Environment(AuthViewModel.self) var authViewModel
    @Environment(\.dismiss) var dismiss
    
    let user: User
    let isAnonymous: Bool
    
    var body: some View {
        NavigationStack {
            Group {
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
                    .hide(if: isAnonymous)
                    
                    Section {
                        NavigationLink("Details") {
                            Text("show user details")
                        }
                        NavigationLink("Order History") {
                            Text("show users transactions")
                        }
                    }
                    .hide(if: isAnonymous || user.role == .admin)
                    
                    Section {
                        HStack {
                            Spacer()
                            Button(role: .destructive) {
                                authViewModel.signOut()
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
                    .hide(if: isAnonymous)
                    
                    Section {
                        NavigationLink(destination: {
                            RegistrationView()
                        }, label: {
                            Text("Create Account")
                                .fontWeight(.semibold)
                        })
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Color.white)
                    .listRowBackground(Color.blue)
                    .hide(if: !isAnonymous)
                }
            }
            .navigationTitle("Account")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    UserProfileSheetView(user: User.MOCK_USER, isAnonymous: true)
        .environment(AuthViewModel())
}
