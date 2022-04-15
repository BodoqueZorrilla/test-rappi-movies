//
//  BehaviorRelay+Extension.swift
//  test-rappi-movies
//
//  Created by Sergio Zorrilla Arellano on 15/04/22.
//

import Foundation
import RxSwift
import RxCocoa

extension BehaviorRelay where Element: RangeReplaceableCollection {
    func add(element: Element.Element) {
        var array = self.value
        array.append(element)
        self.accept(array)
    }
}
