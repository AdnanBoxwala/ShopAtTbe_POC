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
    
    @State private var authFailed = false
    @State private var alertTitle = ""
    @State private var alertMessage = "Please try again."
    
    private var incompleteForm: Bool {
        firstName.isEmpty || lastName.isEmpty || emailId.isEmpty || password.isEmpty || confirmPassword.isEmpty
    }
    
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
                        TbeButton(title: "SIGN UP", systemName: "arrow.right") {
                            Task {
                                do {
                                    try await authViewModel.createUser(firstName: firstName, lastName: lastName, dateOfBirth: dateOfBirth, withEmail: emailId, password: password)
                                } catch {
                                    alertTitle = "Failed to create user."
                                    authFailed = true
                                }
                            }
                        }
                        .disabled(incompleteForm)
                    }
                    .listRowBackground(Color.clear)
                }
            }
            .alert(alertTitle, isPresented: $authFailed) {
                Button("Ok") {
                    authFailed = false
                }
            } message: {
                Text(alertMessage)
            }
            .navigationTitle("Registration")
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
