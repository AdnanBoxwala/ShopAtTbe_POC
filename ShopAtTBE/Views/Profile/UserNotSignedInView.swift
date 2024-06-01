//
//  UserNotLoggedInView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 30.05.24.
//

import SwiftUI

struct UserNotSignedInView: View {
    @State private var showSignInSheet = false
    
    var body: some View {
        NavigationStack {
            Button {
                showSignInSheet.toggle()
            } label: {
                VStack {
                    HStack {
                        Text("Log in to account")
                            .foregroundStyle(Color.white)
                            .fontWeight(.semibold)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding(.horizontal)
                    
                    Spacer()
                }
            }
            .sheet(isPresented: $showSignInSheet, content: {
                LoginView()
            })
        }
    }
}

#Preview {
    UserNotSignedInView()
        .environment(AuthViewModel())
}
