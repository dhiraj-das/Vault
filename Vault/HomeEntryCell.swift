//
//  HomeTableViewCell.swift
//  Vault
//
//  Created by Dhiraj Das on 12/23/16.
//  Copyright © 2016 Mala Das. All rights reserved.
//

import UIKit

class HomeEntryCell: MWSwipeableTableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var displayImage: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var closeDescriptionText: UITextView!
    @IBOutlet weak var passwordLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        displayImage.layer.cornerRadius = 5
        setupAppearance()
        setupButtons()
    }
    
    private func setupAppearance() {
        descriptionTextView.textContainer.lineFragmentPadding = 0
        descriptionTextView.textContainerInset = UIEdgeInsets.zero
        closeDescriptionText.textContainer.lineFragmentPadding = 0
        closeDescriptionText.textContainerInset = UIEdgeInsets.zero
    }
    
    private func setupButtons() {
        let button = RoundedCornerButton(frame: .zero)
        button.cornerRadius = 4
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.orangeButton()
        button.setTitle("Delete", for: .normal)
        rightButton = button
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
    }
}

