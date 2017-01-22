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
        navigationController?.setNavigationBarHidden(false, animated: false)
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = UIColor.navigationBar()
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = "Vault"
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.black, NSFontAttributeName: UIFont(name: "Avenir-Book", size: 18)!]
        let settingsButton = UIBarButtonItem(image: UIImage(named: "settings"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(settingsPressed))
        let addButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: nil)
        let addNewButton = UIBarButtonItem(image: UIImage(named: "add_new"), style: .plain, target: self, action: #selector(addNewPressed))
        navigationItem.leftBarButtonItem = settingsButton
        navigationItem.rightBarButtonItem = addNewButton
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.lightContent, animated: false)
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
