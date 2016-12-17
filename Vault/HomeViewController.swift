//
//  HomeViewController.swift
//  Vault
//
//  Created by Dhiraj Das on 12/17/16.
//  Copyright © 2016 Mala Das. All rights reserved.
//

import Foundation
import UIKit
import KCFloatingActionButton

class HomeViewController : UITableViewController, KCFloatingActionButtonDelegate {
    
    let fab = KCFloatingActionButton()
    var model = [String]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        layoutFAB()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        fab.removeFromSuperview()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor.blue
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func layoutFAB() {
        let item = KCFloatingActionButtonItem()
        item.buttonColor = UIColor.blue
        item.circleShadowColor = UIColor.red
        item.titleShadowColor = UIColor.blue
        item.title = "Custom item"
        item.handler = { item in
            print("ksgjkglgjslgjls")
        }
        
//        fab.addItem(title: "I got a title")
//        fab.addItem("I got a icon", icon: UIImage(named: "icShare"))
//        fab.addItem("I got a handler", icon: UIImage(named: "icMap")) { item in
//            let alert = UIAlertController(title: "Hey", message: "I'm hungry...", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "Me too", style: .default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//        }
        //fab.addItem(item: item)
        fab.fabDelegate = self
        UIApplication.shared.keyWindow?.addSubview(fab)
        //view.addSubview(fab)
        
    }
    
    func KCFABOpened(_ fab: KCFloatingActionButton) {
        print("FAB Opened")
    }
    
    func KCFABClosed(_ fab: KCFloatingActionButton) {
        print("FAB Closed")
    }
    
    func emptyKCFABSelected(_ fab: KCFloatingActionButton) {
//        let a = "sgg"
//        model.append(a)
//        tableView.reloadData()
        let vc = storyboard?.instantiateViewController(withIdentifier: "NewEntryViewController") as! NewEntryViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}
