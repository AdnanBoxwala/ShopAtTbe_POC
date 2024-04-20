//
//  testview.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 09.03.24.
//

import SwiftUI

struct UploadSuccessView: View {
    
    var body: some View {
        Rectangle()
            .frame(width: 150, height: 150)
            .foregroundStyle(Color.gray)
            .opacity(0.4)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .overlay {
                VStack {
                    Text("Done!")
                        .foregroundStyle(Color.green)
                        .bold()
                        .font(.title2)
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundStyle(.green)
                }
            }
    }
}


#Preview {
    UploadSuccessView()
}
