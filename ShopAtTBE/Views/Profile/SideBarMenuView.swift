//
//  SideBarMenuView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 26.04.24.
//

import SwiftUI

struct SideBarMenuView: View {
    @Environment(AuthViewModel.self) var authViewModel
    
    var user: User?
    var isAnonymous: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(authViewModel.butterflyEffectUser?.firstName ?? "") \(authViewModel.butterflyEffectUser?.lastName ?? "")")
                .font(.largeTitle)
                .padding(.bottom, 30)
            
            Button {
                print("show users details")
            } label: {
                HStack {
                    Image(systemName: "pencil.and.list.clipboard")
                    Text("My Details")
                        .padding(.leading)
                }
                .font(.title2)
            }
            .padding(.bottom)
            
            Button {
                print("show users orders")
            } label: {
                HStack {
                    Image(systemName: "archivebox.fill")
                    Text("My Orders")
                        .padding(.leading)
                }
                .font(.title2)
            }
            .padding(.bottom)
            
            Button(role: .destructive) {
                authViewModel.signOut()
            } label: {
                Text("Log Out")
                    .bold()
            }
            .buttonStyle(BorderedProminentButtonStyle())
        }
        .foregroundStyle(Color.primary)
        .padding(.leading)
    }
}

#Preview {
    SideBarMenuView()
        .environment(AuthViewModel())
}
