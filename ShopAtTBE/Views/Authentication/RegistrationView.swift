//
//  RegistrationView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 09.03.24.
//

import SwiftUI

// TODO: focusstate for login and registration view
// TODO: automatically go to next field

struct RegistrationView: View {
    @Environment(AuthViewModel.self) var authViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var dateOfBirth: Date = .now
    @State private var emailId: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    @State private var showPassword: Bool = false
    
    let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let startComponents = DateComponents(year: Calendar.current.component(.year, from: Date.now) - 100, month: 1, day: 1)
        return calendar.date(from:startComponents)! ... Date.now
    }()
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section {
                        TextField("First Name", text: $firstName)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.words)
                        
                        TextField("Last Name", text: $lastName)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.words)
                        
                        DatePicker("Date of Birth", selection: $dateOfBirth, in: dateRange, displayedComponents: [.date])
                            .datePickerStyle(.compact)
                    } header: {
                        Text("Personal details")
                    }
                    
                    Section {
                        TextField("Email Address", text: $emailId)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                        
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
                        SecureField("Confirm password", text: $confirmPassword)
                    } header: {
                        Text("Login details")
                    }
                    
                    Section {
                        Button {
                            Task {
                                try await authViewModel.createUser(firstName: firstName, lastName: lastName, dateOfBirth: dateOfBirth, withEmail: emailId, password: password)
                            }
                        } label: {
                            HStack {
                                Text("SIGN UP")
                                    .foregroundStyle(Color.white)
                                    .fontWeight(.semibold)
                                Image(systemName: "arrow.right")
                                    .foregroundStyle(Color.white)
                                    .fontWeight(.semibold)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .listRowBackground(Color.blue)
                }
                
                
//                Spacer()
//                HStack {
//                    
//                    Button {
//                        dismiss()
//                    } label: {
//                        VStack(spacing: 2) {
//                            Text("Already a user?")
//                            Text("Sign in")
//                                .fontWeight(.bold)
//                        }
//                    }
//                    
//                    Spacer()
//                    Button {
//                        // add functionality to switch to guest view
//                    } label: {
//                        VStack(spacing: 2) {
//                            Text("Guest\nAccess")
//                                .fontWeight(.bold)
//                        }
//                    }
//                }
//                .padding()
                
//                Spacer()
            }
            .navigationTitle("Registration")
//            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    RegistrationView()
        .environment(AuthViewModel())
}
