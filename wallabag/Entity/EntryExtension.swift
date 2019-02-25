//
//  EntryExtension.swift
//  wallabag
//

import Foundation
import CoreSpotlight
import MobileCoreServices

extension Entry {
    var spotlightIdentifier: String {
        return "\(Bundle.main.bundleIdentifier!).spotlight.\(Int(id))"
    }

    var searchableItemAttributeSet: CSSearchableItemAttributeSet {
        let searchableItemAttributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
        searchableItemAttributeSet.title = title
        searchableItemAttributeSet.contentDescription = content?.withoutHTML

        return searchableItemAttributeSet
    }
}
