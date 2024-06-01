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
    
    var body: some View {
        NavigationStack {
            Group {
                if authViewModel.userFetchedFromDatabase {
                    let user = authViewModel.butterflyEffectUser!
                    switch user.role {
                    case .admin:
                        AdminSignedInView(user: user)
                    case .customer:
                        UserSignedInView(user: user)
                    }
                } else {
                    UserNotSignedInView()
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
    UserProfileSheetView()
        .environment(AuthViewModel())
}
