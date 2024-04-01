//
//  testview.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 09.03.24.
//

import SwiftUI

struct UploadSuccessView: View {
    @State private var opacity = 1.0
    
    var body: some View {
        Rectangle()
            .frame(width: 150, height: 150)
            .foregroundStyle(Color.gray)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .overlay {
                VStack {
                    Text("Uploaded!")
                        .font(.title2)
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundStyle(.green)
                }
            }
            .opacity(opacity)
            .animation(.easeIn, value: opacity)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    opacity = 0
                }
            }
    }
}


#Preview {
    UploadSuccessView()
}
