//
//  HomeViewController.swift
//  Vault
//
//  Created by Dhiraj Das on 12/17/16.
//  Copyright © 2016 Mala Das. All rights reserved.
//

import UIKit
import RealmSwift
import GoogleMobileAds

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var bannerAd: GADBannerView!
    let kCloseCellHeight: CGFloat = 84
    let kCloseCellWithDescriptionHeight: CGFloat = 120
    let kOpenCellHeight: CGFloat = 122
    let kOpenCellWithDescriptionHeight: CGFloat = 150
    var entries: Results<Entry>?
    var mainEntries: Results<Entry>?
    var interstitial: GADInterstitial!
    var cellHeights = [CGFloat]()
    var blurEffectView: UIVisualEffectView?
    lazy var searchBar = UISearchBar(frame: CGRect.zero)
    var searchButton: UIBarButtonItem!
    var settingsButton: UIBarButtonItem!
    var addNewButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBannerAd()
        setupNavBar()
        tableview.estimatedRowHeight = kCloseCellHeight
        tableview.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadEntries()
        createCellHeightsArray()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupNavBar()
        self.blurEffectView?.removeFromSuperview()
    }
    
    func createCellHeightsArray() {
        if let entries = entries {
            for i in 0..<entries.count {
                if entries[i].details.characters.count > 0{
                    cellHeights.append(kCloseCellWithDescriptionHeight)
                } else {
                    cellHeights.append(kCloseCellHeight)
                }
                tableview.reloadData()
            }
        }
    }
    
    func loadEntries() {
        let configuration = Realm.Configuration(encryptionKey: KeychainHelper.getKey())
        let realm = try? Realm(configuration: configuration)
        mainEntries = realm?.objects(Entry.self)
        entries = mainEntries
    }
    
    func setupNavBar() {
        AppearanceManager.setNavigationBarHidden(forViewController: self, hidden: false)
        navigationController?.navigationBar.barTintColor = UIColor.navigationBar()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        navigationItem.title = "Vault"
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "Avenir-Book", size: 18)!]
        settingsButton = UIBarButtonItem(image: UIImage(named: "settings"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(settingsPressed))
        searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonPressed))
        //        let buttonView = UIView(frame: CGRect(x: 10, y: 0, width: 60, height: 30))
        //        buttonView.backgroundColor = UIColor.barButton()
        //        buttonView.layer.cornerRadius = 15
        //        buttonView.clipsToBounds = true
        //        addNewButton = UIBarButtonItem(customView: buttonView)
        //        addNewButton.action = #selector(addNewPressed)
        //        addNewButton.target = self
        //        addNewButton.title = "Add"
        addNewButton = UIBarButtonItem(image: UIImage(named: "add_new"), style: .plain, target: self, action: #selector(addNewPressed))
        navigationItem.leftBarButtonItem = settingsButton
        navigationItem.rightBarButtonItems = [addNewButton, searchButton]
        searchBar.delegate = self
        searchBar.searchBarStyle = .default
        searchBar.showsCancelButton = true
        searchBar.placeholder = "Search"
        searchBar.isTranslucent = true
    }
    
    @objc func settingsPressed() {
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = self.view.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.blurEffectView = blurEffectView
            UIView.animate(withDuration: 0.5, animations: {
                self.view.addSubview(blurEffectView)
            }, completion: { (Bool) in
                self.pushSettingsViewController()
            })
        } else {
            pushSettingsViewController()
        }
    }
    
    private func pushSettingsViewController() {
        if let settingsViewController = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController {
            navigationController?.pushViewController(settingsViewController, animated: true)
        }
    }
    
    @objc func addNewPressed() {
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = self.view.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.blurEffectView = blurEffectView
            UIView.animate(withDuration: 0.5, animations: {
                self.view.addSubview(blurEffectView)
            }, completion: { (Bool) in
                let newEntryViewController = self.storyboard?.instantiateViewController(withIdentifier: "EntryViewController") as! EntryViewController
                self.present(newEntryViewController, animated: true, completion: nil)

            })
        } else {
            let newEntryViewController = self.storyboard?.instantiateViewController(withIdentifier: "EntryViewController") as! EntryViewController
            self.present(newEntryViewController, animated: true, completion: nil)
        }
    }
}

extension HomeViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let entries = entries {
            return entries.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HomeEntryCell {
            cell.delegate = self
            cell.tag = indexPath.row
            cell.titleLabel.text = entries?[indexPath.item].website
            cell.subtitleLabel.text = entries?[indexPath.item].username
            cell.displayImage.image = UIImage(data: entries?[indexPath.item].imageData as! Data)
            cell.descriptionTextView.text = entries?[indexPath.item].details
            cell.closeDescriptionText.text = entries?[indexPath.item].details
            cell.passwordLabel.text = entries?[indexPath.item].password
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[(indexPath as NSIndexPath).row]
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard case let cell as HomeEntryCell = tableView.cellForRow(at: indexPath), let entries = entries else {
            return
        }
        if cellHeights[indexPath.row] == kCloseCellHeight || cellHeights[indexPath.row] == kCloseCellWithDescriptionHeight {                                // open cell
            if entries[indexPath.row].details.characters.count > 0 {
                cellHeights[indexPath.row] = kOpenCellWithDescriptionHeight
            } else {
                cellHeights[indexPath.row] = kOpenCellHeight
            }
            cell.closeDescriptionText.isHidden = true
            cell.descriptionTextView.isHidden = false
            cell.passwordLabel.isHidden = false
        } else {                                                            // close cell
            if entries[indexPath.row].details.characters.count > 0 {
                cellHeights[indexPath.row] = kCloseCellWithDescriptionHeight
            } else {
                cellHeights[indexPath.row] = kCloseCellHeight
            }
            cell.closeDescriptionText.isHidden = false
            cell.descriptionTextView.isHidden = true
            cell.passwordLabel.isHidden = true
        }
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: { _ in
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)
    }
}

extension HomeViewController: MWSwipeableTableViewCellDelegate {
    func swipeableTableViewCellDidRecognizeSwipe(cell: MWSwipeableTableViewCell) {
        
    }
    
    func swipeableTableViewCellDidTapLeftButton(cell: MWSwipeableTableViewCell) {
        print("did tap left button")
    }
    
    func swipeableTableViewCellDidTapRightButton(cell: MWSwipeableTableViewCell) {
        deleteObjectInIndexPath(index: cell.tag) { success in
            self.tableview.deleteRows(at: [IndexPath(row: cell.tag, section: 0)], with: .fade)
            self.loadEntries()
            self.createCellHeightsArray()
        }
    }
    
    private func deleteObjectInIndexPath(index: Int, completion: (_ success: Bool) -> Void) {
        let configuration = Realm.Configuration(encryptionKey: KeychainHelper.getKey())
        let realm = try? Realm(configuration: configuration)
        let objectToDelete = mainEntries?[index]
        realm?.beginWrite()
        realm?.delete(objectToDelete!)
        do {
            _ = try realm?.commitWrite()
            completion(true)
        } catch {
            completion(false)
        }
    }
}

extension HomeViewController: GADBannerViewDelegate{
//    func createAndLoadInterstitial() {
//        interstitial = GADInterstitial(adUnitID: "ca-app-pub-4023839110527071/4805410140")
//        interstitial.delegate = self
//        let request = GADRequest()
//        request.testDevices = [ kGADSimulatorID, "282910d03e92c55c9127fe98f85612c8" ]
//        interstitial.load(request)
//    }
//    
//    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
//        createAndLoadInterstitial()
//    }
    
    func loadBannerAd() {
        bannerAd.adUnitID = "ca-app-pub-4023839110527071/9096008941"
        bannerAd.rootViewController = self
        bannerAd.isAutoloadEnabled = true
        let request = GADRequest()
        request.testDevices = [ kGADSimulatorID, "282910d03e92c55c9127fe98f85612c8" ]
        bannerAd.load(request)
    }
}

extension HomeViewController: UISearchBarDelegate {
    @objc func searchButtonPressed() {
        showSearchBar()
    }
    
    func showSearchBar() {
        navigationItem.titleView = searchBar
        navigationItem.setLeftBarButton(nil, animated: true)
        navigationItem.setRightBarButtonItems(nil, animated: true)
        navigationItem.hidesBackButton = true
        searchBar.alpha = 0
        searchBar.text = nil
        UIView.animate(withDuration: 0.5, animations: {
            self.searchBar.alpha = 1
        }, completion: { finished in
            self.searchBar.becomeFirstResponder()
        })
    }
    
    func hideSearchBar() {
        UIView.animate(withDuration: 0.3, animations: {
            self.searchBar.alpha = 0
        }, completion: { finished in
            self.navigationItem.titleView = nil
            self.navigationItem.title = "Vault"
            self.navigationItem.setLeftBarButton(self.settingsButton, animated: true)
            self.navigationItem.rightBarButtonItems = [self.addNewButton, self.searchButton]
        })
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        hideSearchBar()
        entries = mainEntries
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let configuration = Realm.Configuration(encryptionKey: KeychainHelper.getKey())
        let realm = try? Realm(configuration: configuration)
        let predicate = NSPredicate(format: "website contains[c] %@", searchText)
        entries = realm?.objects(Entry.self).filter(predicate)
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
    }
}
