//
//  LoginView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 09.03.24.
//

import SwiftUI

struct LoginView: View {
    @Environment(AuthViewModel.self) var authViewModel
    
    @State private var emailId: String = ""
    @State private var password: String = ""
    
    @State private var showPassword: Bool = false
    
    // TODO: use switch case here
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                VStack(alignment: .leading, spacing: 20) {
                    TextField("Email Address", text: $emailId)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                    
                    Divider()
                    
                    ZStack(alignment: Alignment(horizontal: .trailing, vertical: .center), content: {
                        if showPassword {
                            TextField("Password", text: $password)
                                .autocorrectionDisabled()
                                .textInputAutocapitalization(.never)
                        } else {
                            SecureField("Password", text: $password)
                                .autocorrectionDisabled()
                                .textInputAutocapitalization(.never)
                        }
                        
                        Button {
                            showPassword.toggle()
                        } label: {
                            showPassword ? Image(systemName: "eye.slash") : Image(systemName: "eye")
                        }
                    })
                }
                .padding()
                .background(.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 15))
                
                Button {
                    Task {
                        try await authViewModel.signIn(withEmail: emailId, password: password)
                    }
                } label: {
                    HStack {
                        Text("SIGN IN")
                            .foregroundStyle(Color.white)
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                            .foregroundStyle(Color.white)
                            .fontWeight(.semibold)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack(spacing: 2) {
                        Text("Dont have an Account?")
                        Text("Sign Up")
                            .fontWeight(.bold)
                    }
                }
            }
            .navigationTitle("The Butterfly Effect")
            .padding(.horizontal)
        }
    }
}

#Preview {
    LoginView()
}
