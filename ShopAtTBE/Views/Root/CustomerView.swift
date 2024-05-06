//
//  CustomerView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 12.03.24.
//

import SwiftUI

struct CustomerView: View {
    @State var viewModel = ViewModel()

    var body: some View {
        CatalogView()
            .environment(viewModel)
    }
}

#Preview {
    CustomerView()
        .environment(AuthViewModel())
}
