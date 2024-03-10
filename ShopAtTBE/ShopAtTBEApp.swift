//
//  ShopAtTBEApp.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 14.02.24.
//

import SwiftUI

enum AuthResponse {
    case currentUser, noUser
}

@main
struct ShopAtTBEApp: App {
    
    // Firebase API call
    let response = AuthResponse.noUser
    
    // get user info from response
    let dummyUser = User(id: UUID(), firstName: "Adnan", lastName: "Boxwala", dateOfBirth: .now, emailId: "test@gmail.com", role: .admin)
        
    var body: some Scene {
        WindowGroup {
            switch response {
            case .currentUser:
                ContentView()
                    .environmentObject(dummyUser)
            case .noUser:
                LoginView()
            }
        }
    }
}
