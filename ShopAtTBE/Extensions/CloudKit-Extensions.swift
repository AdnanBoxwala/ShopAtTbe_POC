//
//  CloudKit-Extensions.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 17.04.24.
//

import CloudKit
import Foundation
import UIKit

extension CKAsset {
    func toUiImage() -> UIImage? {
        guard let url = self.fileURL else {
            print("no url")
            return nil
        }
        guard let data = try? Data(contentsOf: url) else {
            print("could not load data")
            return nil
        }
        
        return UIImage(data: data)
    }
}
