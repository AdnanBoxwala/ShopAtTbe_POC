//
//  RegistrationView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 09.03.24.
//

import SwiftUI

struct RegistrationView: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var dateofBirth: Date = .now
    @State private var emailId: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    @State private var showPassword: Bool = false
    @Environment(\.dismiss) var dismiss
        
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
                        
                        DatePicker("Date of Birth", selection: $dateofBirth, in: dateRange, displayedComponents: [.date])
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
                            // register user in firebase
                            print("button pressed")
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
                
                
                Spacer()
                HStack {
                    
                    Button {
                        dismiss()
                    } label: {
                        VStack(spacing: 2) {
                            Text("Already a user?")
                            Text("Sign in")
                                .fontWeight(.bold)
                        }
                    }
                    
                    Spacer()
                    Button {
                        // add functionality to switch to guest view
                    } label: {
                        VStack(spacing: 2) {
                            Text("Guest\nAccess")
                                .fontWeight(.bold)
                        }
                    }
                }
                .padding()
                
                Spacer()
            }
            .navigationTitle("Registration")
//            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    RegistrationView()
}
