//
//  NavigationBar+Extension.swift
//  test-rappi-movies
//
//  Created by Sergio Zorrilla Arellano on 18/04/22.
//

import Foundation
import UIKit

extension UINavigationBar {
    func customNavigationBar() {
        self.tintColor = .white
        self.barTintColor = .black
        self.isTranslucent = false
        self.prefersLargeTitles = true

        self.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
    }
}
