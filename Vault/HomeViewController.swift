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
    @IBOutlet weak var bannedAd: GADBannerView!
    private var newEntryButton: FloatingActionButton!
    let kCloseCellHeight: CGFloat = 84
    let kCloseCellWithDescriptionHeight: CGFloat = 120
    let kOpenCellHeight: CGFloat = 122//119
    let kOpenCellWithDescriptionHeight: CGFloat = 150
    var entries: Results<Entry>!
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
        tableview.estimatedRowHeight = kCloseCellHeight
        tableview.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
        loadEntries()
        createCellHeightsArray()
        blurEffectView?.removeFromSuperview()
    }
    
    func setupNavBar() {
        UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.lightContent, animated: false)
        navigationController?.setNavigationBarHidden(false, animated: false)
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
    
    func createCellHeightsArray() {
        for i in 0..<entries.count {
            if entries[i].details.characters.count > 0{
                cellHeights.append(kCloseCellWithDescriptionHeight)
            } else {
                cellHeights.append(kCloseCellHeight)
            }
            tableview.reloadData()
        }
    }
    
    @objc func settingsPressed() {
        
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
            self.view.backgroundColor = UIColor.backgroundDark()
        }
    }
    
    func loadEntries() {
        let configuration = Realm.Configuration(encryptionKey: KeychainHelper.getKey())
        let realm = try! Realm(configuration: configuration)
        entries = realm.objects(Entry.self)
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HomeEntryCell {
            cell.titleLabel.text = entries[indexPath.item].website
            cell.subtitleLabel.text = entries[indexPath.item].username
            cell.displayImage.image = UIImage(data: entries[indexPath.item].imageData as Data)
            cell.descriptionTextView.text = entries[indexPath.item].details
            cell.closeDescriptionText.text = entries[indexPath.item].details
            cell.passwordLabel.text = entries[indexPath.item].password
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
        guard case let cell as HomeEntryCell = tableView.cellForRow(at: indexPath) else {
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
        bannedAd.adUnitID = "ca-app-pub-4023839110527071/9096008941"
        bannedAd.rootViewController = self
        bannedAd.isAutoloadEnabled = true
        let request = GADRequest()
        request.testDevices = [ kGADSimulatorID, "282910d03e92c55c9127fe98f85612c8" ]
        bannedAd.load(request)
    }
}

extension HomeViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
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
    }
}
