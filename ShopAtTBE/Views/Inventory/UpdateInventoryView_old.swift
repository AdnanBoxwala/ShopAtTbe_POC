//
//  UpdateInventoryView_old.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 24.02.24.
//

import SwiftUI

struct UpdateInventoryView_old: View {
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink {
                    AddInventoryItemView()
                } label: {
                    Label("Add item", systemImage: "plus.circle")
                        .font(.title)
                        .foregroundStyle(Color.primary)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.secondary)
                        .clipShape(.capsule)
                }
                
                NavigationLink {
//                    UpdateInventoryItemView()
                } label: {
                    Label("Update item", systemImage: "goforward.plus")
                        .font(.title)
                        .foregroundStyle(Color.primary)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.secondary)
                        .clipShape(.capsule)
                }
            }
            .navigationTitle("T.B.E Database")
            .padding(.horizontal)
        }
    }
}

#Preview {
    UpdateInventoryView_old()
        .environment(UpdateInventoryView.ViewModel())
}