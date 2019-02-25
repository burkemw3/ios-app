//
//  ThemeManager.swift
//  wallabag
//

import UIKit

protocol ThemeProtocol {
    var name: String {get}
    var color: UIColor {get}
    var tintColor: UIColor {get}
    var barStyle: UIBarStyle {get}
    var backgroundColor: UIColor {get}
    var navigationBarBackground: UIImage? {get}
    var backgroundSelectedColor: UIColor {get}
}

class ThemeManager {
    static let manager = ThemeManager()
    private init() {
        currentTheme = White()
    }

    private var themes: [ThemeProtocol] = [White(), Light(), Dusk(), Night(), Black()]
    private var currentTheme: ThemeProtocol

    func apply(_ themeName: String) {
        updateCurrentTheme(themeName)

        let sharedApplication = UIApplication.shared
        sharedApplication.delegate?.window??.tintColor = currentTheme.tintColor

        let uiButton = UIButton.appearance()
        uiButton.tintColor = currentTheme.tintColor

        let uiBarButton = UIBarButtonItem.appearance()
        uiBarButton.tintColor = currentTheme.tintColor
        uiBarButton.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont(name: "UbuntuTitling-Bold", size: 15.0)!
            ], for: .normal)

        let uiLabel = UILabel.appearance()
        uiLabel.textColor = currentTheme.color

        let bar = UINavigationBar.appearance()
        bar.setBackgroundImage(currentTheme.navigationBarBackground, for: .default)
        bar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: currentTheme.color]
        bar.barStyle = currentTheme.barStyle

        let toolbar = UIToolbar.appearance()
        toolbar.setBackgroundImage(currentTheme.navigationBarBackground, forToolbarPosition: .any, barMetrics: .default)

        UITextView.appearance().backgroundColor = currentTheme.backgroundColor

        UITableView.appearance().backgroundColor = currentTheme.backgroundColor
        UITableViewCell.appearance().backgroundColor = currentTheme.backgroundColor

        NotificationCenter.default.post(name: Notification.Name.themeUpdated, object: nil)

        for window in UIApplication.shared.windows {
            for view in window.subviews {
                view.removeFromSuperview()
                window.addSubview(view)
            }
            window.rootViewController?.setNeedsStatusBarAppearanceUpdate()
        }
    }

    private func updateCurrentTheme(_ themeName: String) {
        for theme in themes where theme.name == themeName {
            currentTheme = theme
        }
    }

    func getColor() -> UIColor {
        return currentTheme.color
    }

    func getTintColor() -> UIColor {
        return currentTheme.tintColor
    }

    func getBackgroundColor() -> UIColor {
        return currentTheme.backgroundColor
    }

    func getBackgroundSelectedColor() -> UIColor {
        return currentTheme.backgroundSelectedColor
    }

    func getNavigationBarBackground() -> UIImage? {
        return currentTheme.navigationBarBackground
    }

    func getThemes() -> [ThemeProtocol] {
        return themes
    }

    func getBarStyle() -> UIBarStyle {
        return currentTheme.barStyle
    }
}

extension Notification.Name {
    static var themeUpdated: Notification.Name {
        return Notification.Name(rawValue: "theme.updated")
    }
}
