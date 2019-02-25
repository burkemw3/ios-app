//
//  Date.swift
//  wallabag
//

import Foundation

extension Date {
    static func fromISOString(_ string: String) -> Date? {
        let dateFormatter = DateFormatter()
        _ = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        _ = "2018-04-09T10:27:23+0200"
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssX"

        return dateFormatter.date(from: string)
    }
}
