//
//  ThemeChoiceTableViewController.swift
//  wallabag
//

import UIKit
import WallabagCommon

final class ThemeChoiceTableViewController: UITableViewController {

    let setting = WallabagSetting()
    var themes: [ThemeProtocol] = ThemeManager.manager.getThemes()

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return themes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let theme: ThemeProtocol = themes[indexPath.row]

        cell.textLabel?.text = theme.name.ucFirst

        if theme.name == setting.get(for: .theme) {
            cell.accessoryType = .checkmark
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for row in 0 ... tableView.numberOfRows(inSection: indexPath.section) {
            tableView.cellForRow(at: IndexPath(row: row, section: indexPath.section))?.accessoryType = .none
        }
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        tableView.deselectRow(at: indexPath, animated: true)

        let selectedTheme = themes[indexPath.row]

        setting.set(selectedTheme.name, for: .theme)
        ThemeManager.manager.apply(selectedTheme.name)

        _ = navigationController?.popViewController(animated: true)
    }
}
