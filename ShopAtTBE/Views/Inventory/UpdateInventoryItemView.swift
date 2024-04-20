//
//  UpdateInventoryItemView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 24.02.24.
//

import CloudKit
import SwiftUI

struct UpdateInventoryItemView: View {
    @Environment(ManageInventoryView.ViewModel.self) var viewModel
    @State var record: ManageInventoryView.FetchedRecord
    
    init(record: ManageInventoryView.FetchedRecord) {
        self._record = State(initialValue: record)
    }
        
    // TODO: go back to previous view
    var body: some View {
        VStack {
            ProductFormView(record: $record)
            
            Button("Delete", role: .destructive) {
                viewModel.removeRecord(record.recordId)
            }
            .padding()
            .background(Color.red)
            .foregroundStyle(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 5))
        }
        .navigationTitle(record.productId)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button("Update") {
                    // save to iCloud
                    Task {
                        viewModel.updateRecord()
                    }
                }
                .disabled(record.name.trimmingCharacters(in: .whitespaces).isEmpty || record.productId.trimmingCharacters(in: .whitespaces).isEmpty || record.assets.isEmpty)
            }
        }

    }
}

#Preview {
    UpdateInventoryItemView(record: ManageInventoryView.FetchedRecord(name: "", price: 0.0, assets: [], description: "", productId: "", quantity: 1, category: .ring, recordId: CKRecord.ID.init(recordName: "test")))
        .environment(ManageInventoryView.ViewModel())
}
