//
//  UserProfileView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 10.03.24.
//

import SwiftUI

struct CustomerProfileView: View {
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
            .padding()
        }
    }
}

#Preview {
    CustomerProfileView(user: ButterflyEffect.MOCK_USER)
        .environment(AuthViewModel())
}
