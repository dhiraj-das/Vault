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
        navigationController?.setNavigationBarHidden(true, animated: false)
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "header")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.textDarkGrey()
        header.tintColor = UIColor.backgroundDark()
        header.textLabel?.font = UIFont(name: "Helvetica Neue", size: 12)
        header.textLabel?.textAlignment = NSTextAlignment.left
        switch section {
        case SettingsSections.general.rawValue:
            header.textLabel?.text = "GENERAL"
        default:
            header.textLabel?.text = "ABOUT"
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: "header")
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    @objc func updateSwitchAtIndexPath(sender: UISwitch) {
        print(sender.isOn)
    }
}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") {
            cell.backgroundColor = UIColor.navigationBar()
            cell.textLabel?.textColor = UIColor.textLightGrey()
            let toggleSwitch = UISwitch()
            cell.accessoryView = toggleSwitch
            toggleSwitch.addTarget(self, action: #selector(updateSwitchAtIndexPath(sender:)), for: UIControlEvents.touchUpInside)
            switch indexPath.section {
            case 0:
                switch indexPath.row {
                case 0:
                    cell.textLabel?.text = "Enable PIN Authentication"
                    toggleSwitch.tag = 55
                    cell.accessoryView?.isHidden = false
                default:
                    cell.accessoryView?.isHidden = true
                }
            default:
                cell.accessoryView?.isHidden = true
            }
            return cell
        }
        return UITableViewCell(style: .default, reuseIdentifier: "cell")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
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
