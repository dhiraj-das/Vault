//
//  HomeViewController.swift
//  Vault
//
//  Created by Dhiraj Das on 12/17/16.
//  Copyright © 2016 Mala Das. All rights reserved.
//

import UIKit
import RealmSwift

class HomeViewController : UITableViewController, FloatingActionButtonDelegate {
    
    private var newEntryButton: FloatingActionButton!
    private var entries : Results<Entry>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadEntries()
//        let entry = Entry(title: "Google", email: "dhiraj.das.05@gmail.com", password: "ggg", details: nil)
//        let entry2 = Entry(title: "Facebook", email: "dhiraj.das.05", password: "gfdgd", details: nil)
//        let entry3 = Entry(title: "GitHub", email: "dhiraj-das", password: "fdkjgk", details: nil)
//        entries = [entry, entry2, entry3]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        layoutFAB()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        newEntryButton.removeFromSuperview()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customizeNavBar()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell
        cell.titleLabel.text = entries[indexPath.row].title
        cell.subtitleLabel.text = entries[indexPath.row].email
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func customizeNavBar() {
        let title = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        title.text = "Home"
        title.font = UIFont(name: "Avenir-Medium", size: 17)
        title.textAlignment = .center
        navigationItem.titleView = title
    }
    
    func layoutFAB() {
        newEntryButton = FloatingActionButton()
        newEntryButton.delegate = self
        newEntryButton.setLabel(title: "+", color: .white)
        newEntryButton.translatesAutoresizingMaskIntoConstraints = false
        UIApplication.shared.keyWindow?.addSubview(newEntryButton)
        let trailing = NSLayoutConstraint(item: newEntryButton, attribute: .trailing, relatedBy: .equal, toItem: UIApplication.shared.keyWindow!, attribute: .trailing, multiplier: 1, constant: -30)
        let height = NSLayoutConstraint(item: newEntryButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 55)
        let width = NSLayoutConstraint(item: newEntryButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 55)
        let bottom = NSLayoutConstraint(item: newEntryButton, attribute: .bottom, relatedBy: .equal, toItem: UIApplication.shared.keyWindow!, attribute: .bottom, multiplier: 1, constant: -30)
        UIApplication.shared.keyWindow?.addConstraints([height, width,trailing,bottom])
    }
    
    func didPressButton(sender: FloatingActionButton) {
        let newEntryViewController = storyboard?.instantiateViewController(withIdentifier: "NewEntryViewController") as! NewEntryViewController
        present(newEntryViewController, animated: true, completion: nil)
    }
    
    func loadEntries() {
        let realm = try! Realm()
        entries = realm.objects(Entry.self)
    }
}
