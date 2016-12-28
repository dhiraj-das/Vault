//
//  NewEntryViewController.swift
//  Vault
//
//  Created by Dhiraj Das on 12/17/16.
//  Copyright © 2016 Mala Das. All rights reserved.
//

import UIKit
import RealmSwift

class NewEntryViewController: UIViewController {
    
    @IBOutlet weak var navigationItemView: UINavigationItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDropdown()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupAppearance()
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func setupAppearance() {
        customizeNavBar()
    }
    
    func customizeNavBar() {
        let title = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        title.text = "New Entry"
        title.font = UIFont(name: "Avenir-Medium", size: 17)
        title.textAlignment = .center
        navigationItemView.titleView = title
        cancelButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Avenir-Book", size: 18.0)!], for: UIControlState.normal)
    }
    
    func setupDropdown() {
        /*let chooseImageDropdown = DropDown()
         chooseImageDropdown.anchorView = chooseArticleButton
        
            // Will set a custom with instead of anchor view width
            //		dropDown.width = 100
            
            // By default, the dropdown will have its origin on the top left corner of its anchor view
            // So it will come over the anchor view and hide it completely
            // If you want to have the dropdown underneath your anchor view, you can do this:
        chooseArticleDropDown.bottomOffset = CGPoint(x: 0, y: chooseArticleButton.bounds.height)
            
            // You can also use localizationKeysDataSource instead. Check the docs.
        chooseArticleDropDown.dataSource = [
                "iPhone SE | Black | 64G",
                "Samsung S7",
                "Huawei P8 Lite Smartphone 4G",
                "Asus Zenfone Max 4G",
                "Apple Watwh | Sport Edition"
            ]
            
            // Action triggered on selection
            chooseArticleDropDown.selectionAction = { [unowned self] (index, item) in
                self.chooseArticleButton.setTitle(item, for: .normal)
            }
            
            // Action triggered on dropdown cancelation (hide)
            //		dropDown.cancelAction = { [unowned self] in
            //			// You could for example deselect the selected item
            //			self.dropDown.deselectRowAtIndexPath(self.dropDown.indexForSelectedRow)
            //			self.actionButton.setTitle("Canceled", forState: .Normal)
            //		}
            
            // You can manually select a row if needed
            //		dropDown.selectRowAtIndex(3)
 */
        }
    
}
