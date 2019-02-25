//
//  ThemedTableViewCell.swift
//  wallabag
//

import UIKit

class ThemedTableViewCell: UITableViewCell {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _ = NotificationCenter.default.addObserver(forName: Notification.Name.themeUpdated, object: nil, queue: nil) { _ in
            self.setupTheme()
        }

        setupTheme()
    }

    /**
     Apply the current theme to the cell
     */
    func setupTheme() {
        backgroundColor = ThemeManager.manager.getBackgroundColor()
        textLabel?.textColor = ThemeManager.manager.getColor()

        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = ThemeManager.manager.getBackgroundSelectedColor()
    }
}
