//
//  ArticleTableViewCell.swift
//  wallabag
//

import UIKit
import AlamofireImage
import CoreData

final class ArticleTableViewCell: ThemedTableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var website: UILabel!
    @IBOutlet weak var readingTime: UILabel!
    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var readed: UIImageView!
    @IBOutlet weak var starred: UIImageView!

    func present(_ entry: Entry) {
        setupTheme()

        title.text = entry.title
        website.text = entry.domainName

        if !entry.isArchived {
            title.font = UIFont.boldSystemFont(ofSize: 16.0)
            readed.image = #imageLiteral(resourceName: "unreaded")
        } else {
            title.font = UIFont.systemFont(ofSize: 16.0)
            readed.image = #imageLiteral(resourceName: "readed")
        }

        starred.image = entry.isStarred ? #imageLiteral(resourceName: "starred") : #imageLiteral(resourceName: "unstarred")

        readingTime.text = String(format: "Reading time %@".localized, arguments: [Int(entry.readingTime).readingTime])

        previewImage.display(entry: entry)
    }

    override func setupTheme() {
        super.setupTheme()
        title?.textColor = ThemeManager.manager.getColor()
        website?.textColor = ThemeManager.manager.getColor()
        readingTime?.textColor = ThemeManager.manager.getColor()
        readed?.tintColor = ThemeManager.manager.getTintColor()
        starred?.tintColor = ThemeManager.manager.getTintColor()
    }
}
