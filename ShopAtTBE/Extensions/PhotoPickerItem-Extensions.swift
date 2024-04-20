//
//  PhotoPickerItem-Exnteions.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 17.04.24.
//

import CloudKit
import _PhotosUI_SwiftUI

extension PhotosPickerItem {
    func toCkAsset() async -> CKAsset? {
        guard let imageData = try? await self.loadTransferable(type: Data.self) else { return nil }
        
        let temporaryURL = URL.temporaryDirectory.appendingPathComponent(UUID().uuidString).appendingPathExtension("dat")
        do {
            try imageData.write(to: temporaryURL, options: [.atomic, .completeFileProtection])
            return CKAsset(fileURL: temporaryURL)
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
