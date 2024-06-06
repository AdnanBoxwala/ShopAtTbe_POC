//
//  TbeButton.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 02.06.24.
//

import SwiftUI

struct TbeButton: View {
    let action: () -> Void
    let title: String
    let systemName: String?
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .foregroundStyle(Color.white)
                    .fontWeight(.semibold)
                if let systemName {
                    Image(systemName: systemName)
                        .foregroundStyle(Color.white)
                        .fontWeight(.semibold)
                }
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 15))
        }
    }
    
    init(title: String, systemName: String? = nil, action: @escaping () -> Void) {
        self.action = action
        self.title = title
        self.systemName = systemName
    }
}

#Preview {
    TbeButton(title: "Test", systemName: "house") {
        print("test")
    }
}
