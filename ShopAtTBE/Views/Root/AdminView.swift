//
//  AdminView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 12.03.24.
//

import SwiftUI

struct AdminView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem { Label("T.B.E", systemImage: "house") }
            UpdateInventoryView()
                .tabItem { Label("Update Inventory", systemImage: "archivebox.fill")}
        }
    }
}

#Preview {
    AdminView()
}
