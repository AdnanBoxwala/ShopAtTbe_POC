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
                        
                        Text("\(authViewModel.currentUser!.firstName.uppercased()) \(authViewModel.currentUser!.lastName.uppercased())")
                        
                        if !authViewModel.loggedInUser!.isAnonymous {
                            VStack {
                                Spacer()
                                HStack(alignment: .bottom) {
                                    Button {
                                        print("show users orders")
                                    } label: {
                                        VStack {
                                            Image(systemName: "archivebox.fill")
                                                .font(.title)
                                            Text("Orders")
                                                .padding(.horizontal)
                                        }
                                    }
                                    
                                    Divider()
                                        .frame(height: 50)
                                    
                                    Button {
                                        print("show users details")
                                    } label: {
                                        VStack {
                                            Image(systemName: "pencil.and.list.clipboard")
                                                .font(.title)
                                            Text("Details")
                                                .padding(.horizontal)
                                        }
                                    }
                                }
                                Spacer()
                                Button(role: .destructive) {
                                    authViewModel.signOut()
                                } label: {
                                    Text("Log Out")
                                        .padding()
                                }
                            }
                        } else {
                            VStack {
                                Spacer()
                                
                                NavigationLink {
                                    LoginView()
                                } label: {
                                    Text("Sign In with Email")
                                        .foregroundStyle(.primary)
                                }
                            }
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
