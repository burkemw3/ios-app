//
//  ParameterTableViewController.swift
//  wallabag
//

import UIKit
import AVFoundation
import wallabagCommon

final class SettingsTableViewController: UITableViewController {

    let setting = WallabagSetting()

    @IBOutlet weak var currentThemeLabel: UILabel!
    @IBOutlet weak var justifySwitch: UISwitch!
    @IBOutlet weak var badgeSwitch: UISwitch!
    @IBOutlet weak var speechRateSlider: UISlider!

    @IBAction func speechRateChanged(_ sender: UISlider) {
        setting.set(sender.value, for: .speechRate)
    }

    @IBAction func justifySwitch(_ sender: UISwitch) {
        setting.set(sender.isOn, for: .justifyArticle)
    }

    @IBAction func badgeSwitch(_ sender: UISwitch) {
        setting.set(sender.isOn, for: .badgeEnabled)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareDefaultList()

        justifySwitch.setOn(setting.get(for: .justifyArticle), animated: false)
        badgeSwitch.setOn(setting.get(for: .badgeEnabled), animated: false)
        currentThemeLabel.text = setting.get(for: .theme).ucFirst

        speechRateSlider.minimumValue = AVSpeechUtteranceMinimumSpeechRate
        speechRateSlider.maximumValue = AVSpeechUtteranceMaximumSpeechRate
        speechRateSlider.value = setting.get(for: .speechRate)

        _ = NotificationCenter.default.addObserver(forName: Notification.Name.themeUpdated, object: nil, queue: nil) { [weak self] _ in
            self?.tableView.reloadData()
            self?.currentThemeLabel.text = self?.setting.get(for: .theme).ucFirst
        }
    }

    /**
     * @todo clean reuseIdentifier
     */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            for row in 0 ... tableView.numberOfRows(inSection: indexPath.section) {
                tableView.cellForRow(at: IndexPath(row: row, section: indexPath.section))?.accessoryType = .none
            }

            if let cell = tableView.cellForRow(at: indexPath) {
                setting.set(cell.reuseIdentifier!, for: .defaultMode)
                cell.accessoryType = .checkmark
            }

            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.backgroundView?.backgroundColor = ThemeManager.manager.getBackgroundSelectedColor()
            header.textLabel?.textColor = ThemeManager.manager.getColor()
        }
    }

    private func prepareDefaultList() {
        for row in 0 ... tableView.numberOfRows(inSection: 0) {
            if let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) {
                if RetrieveMode(rawValue: cell.reuseIdentifier!)?.rawValue == setting.get(for: .defaultMode) {
                    cell.accessoryType = .checkmark
                }
            }
        }
    }
}
