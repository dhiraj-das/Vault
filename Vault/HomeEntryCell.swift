//
//  HomeTableViewCell.swift
//  Vault
//
//  Created by Dhiraj Das on 12/23/16.
//  Copyright © 2016 Mala Das. All rights reserved.
//

import UIKit
import FoldingCell

class HomeEntryCell: FoldingCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var displayImage: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        foregroundView.layer.cornerRadius = 3
        foregroundView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 3
        containerView.layer.masksToBounds = true
        displayImage.layer.cornerRadius = 5
        setupAppearance()
    }
    
    override func animationDuration(_ itemIndex:NSInteger, type:AnimationType)-> TimeInterval {
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }
    
    private func setupAppearance() {
        //descriptionTextView.textColor = UIColor(red: 140, green: 151, blue: 176, alpha: 1)
        descriptionTextView.textContainer.lineFragmentPadding = 0
        descriptionTextView.textContainerInset = UIEdgeInsets.zero
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
    }
}

