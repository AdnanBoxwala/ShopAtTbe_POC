//
//  ProfileView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 01.04.24.
//

import SwiftUI

struct ProfileView: View {
    let user: ButterflyEffect.User
    var isAnonymous: Bool = false
    
    var body: some View {
        if isAnonymous {
            GuestProfileView(user: user)
        } else {
            switch user.role {
            case .admin:
                AdminProfileView(user: user)
            case .customer:
                CustomerProfileView(user: user)
            }
        }
    }
}

#Preview {
    ProfileView(user: ButterflyEffect.MOCK_USER)
        .environment(AuthViewModel())
}

#Preview {
    ProfileView(user: ButterflyEffect.MOCK_USER, isAnonymous: true)
        .environment(AuthViewModel())
}

#Preview {
    ProfileView(user: ButterflyEffect.MOCK_ADMIN)
        .environment(AuthViewModel())
}
