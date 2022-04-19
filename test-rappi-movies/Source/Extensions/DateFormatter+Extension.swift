//
//  DateFormatter+Extension.swift
//  test-rappi-movies
//
//  Created by Sergio Zorrilla Arellano on 18/04/22.
//

import Foundation

extension DateFormatter {
    static let iso8601Half: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    static let dateWanted: DateFormatter = {
         let formatter = DateFormatter()
         formatter.dateFormat = "MMM d, yyyy"
         return formatter
    }()

    static func string(iso string: String) -> String {
        let date = DateFormatter.iso8601Half.date(from: string) ?? Date()
        return  DateFormatter.dateWanted.string(from: date)
    }
}
