//
//  SettingsViewController.swift
//  Vault
//
//  Created by Dhiraj Das on 1/24/17.
//  Copyright © 2017 Mala Das. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerClassForTableView()
        AppearanceManager.setNavigationBarHidden(forViewController: self, hidden: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        let _ = navigationController?.popViewController(animated: true)
    }
    
    private func registerClassForTableView() {
        tableView.register(HeaderView.self, forHeaderFooterViewReuseIdentifier: "header")
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let headerView = view as? HeaderView else {
            return
        }
        switch section {
        case SettingsSections.general.rawValue:
            headerView.textLabel?.text = "GENERAL"
        default:
            headerView.textLabel?.text = "ABOUT"
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: "header")
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            switch indexPath.row {
            case GeneralSection.changePassword.rawValue:
                self.pushChangePINViewController()
            default:
                break
            }
        }
    }
    
    private func pushChangePINViewController() {
        if let changePINViewController = storyboard?.instantiateViewController(withIdentifier: "ChangePINViewController") as? ChangePINViewController {
            navigationController?.pushViewController(changePINViewController, animated: true)
        }
    }
}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SettingsTableViewCell{
            switch SettingsSections(rawValue: indexPath.section)! {
            case .general:
                switch GeneralSection(rawValue: indexPath.row)! {
                case .enableTouchID:
                    cell.textLabel?.text = "Enable TouchID"
                    cell.toggleSwitch.tag = 1
                    cell.toggleSwitch.isHidden = false
                case .changePassword:
                    cell.toggleSwitch.isHidden = true
                    cell.textLabel?.text = "Change PIN"
                    cell.toggleSwitch.tag = 2
                default:
                    cell.toggleSwitch.isHidden = true
                }
            default:
                cell.toggleSwitch.isHidden = true
                cell.textLabel?.text = AboutSection.about.description
                cell.textLabel?.numberOfLines = 0
            }
            return cell
        }
        return UITableViewCell(style: .default, reuseIdentifier: "cell")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == SettingsSections.about.rawValue {
            return 100
        }
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch SettingsSections(rawValue: section)! {
        case .count:
            //fatalError()
            break
        case .general:
            return GeneralSection.count.rawValue
        case .about:
            return AboutSection.count.rawValue
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsSections.count.rawValue
    }
}

extension SettingsViewController: UIGestureRecognizerDelegate{
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}
