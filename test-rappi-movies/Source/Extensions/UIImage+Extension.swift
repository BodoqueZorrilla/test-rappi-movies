//
//  UIImage+Extension.swift
//  test-rappi-movies
//
//  Created by Sergio Zorrilla Arellano on 20/04/22.
//

import Foundation
import UIKit

extension UIImage {
    func toBase64(compressionQuality: CGFloat = 0.5) -> String{
        if let imageData = self.jpegData(compressionQuality: compressionQuality) {
            return imageData.base64EncodedString(options: [])
        } else {
            return ""
        }
    }

    func fromBase64(data: String) -> UIImage? {
        guard
            let imageData = Data(base64Encoded: data, options: .ignoreUnknownCharacters),
            let image = UIImage(data: imageData)
        else { return nil }
        
        return image
    }
}
