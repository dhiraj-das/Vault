//
//  HomeViewController.swift
//  Vault
//
//  Created by Dhiraj Das on 12/17/16.
//  Copyright © 2016 Mala Das. All rights reserved.
//

import UIKit
import RealmSwift

class HomeViewController : UIViewController, FloatingActionButtonDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var newEntryButton: FloatingActionButton!
    //private var entries : Results<Entry>!
    var entries = [Entry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //loadEntries()
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
        setupNavBar()
    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell
//        cell.titleLabel.text = entries[indexPath.row].title
////        cell.subtitleLabel.text = entries[indexPath.row].email
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
//        navigationController?.pushViewController(detailVC, animated: true)
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return entries.count
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 60
//    }
    
    func setupNavBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationItem.title = "Vault"
        let cancelButton = UIBarButtonItem(image: UIImage(named: "settings"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(cancelPressed))
        cancelButton.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "Avenir-Book", size: 16)!], for: .normal)
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(savePressed))
        saveButton.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "Avenir-Book", size: 16)!], for: .normal)
        navigationItem.leftBarButtonItem = cancelButton
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "Avenir-Book", size: 18)!]
    }
    
    @objc func cancelPressed() {
        
    }
    
    @objc func savePressed() {
        
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
        let newEntryViewController = storyboard?.instantiateViewController(withIdentifier: "EntryViewController") as! EntryViewController
        present(newEntryViewController, animated: true, completion: nil)
    }
    
//    func loadEntries() {
//        let realm = try! Realm()
//        entries = realm.objects(Entry.self)
//    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 13
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HomeEntryCell {
            cell.titleLabel.text = "Google"
            cell.subtitleLabel.text = "dhiraj.das.05@gmail.com"
            return cell
        } else {
            return UICollectionViewCell(frame: CGRect.zero)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 60)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
