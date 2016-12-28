//
//  FloatActionButton.swift
//  Vault
//
//  Created by Dhiraj Das on 12/21/16.
//  Copyright © 2016 Mala Das. All rights reserved.
//

import Foundation
import UIKit

protocol FloatingActionButtonDelegate: class {
    func didPressButton(sender: FloatingActionButton)
}

class FloatingActionButton: UIButton {
    
    var delegate: FloatingActionButtonDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupAppearance()
    }
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 55, height: 55))
        addTarget(self, action: #selector(didPress), for: .touchUpInside)
        setupAppearance()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
    }
    
    @objc private func didPress() {
        delegate?.didPressButton(sender: self)
    }
    
    private func setupAppearance() {
        backgroundColor = UIColor(red: 200/255, green: 64/255, blue: 128/255, alpha: 1)
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.4
        setTitleColor(UIColor.white, for: .normal)
    }
    
    func setLabel(title: String?, color: UIColor?) {
        if let title = title {
            setTitle(title, for: .normal)
            setTitleColor(color, for: .normal)
            titleLabel?.font = UIFont(name: "Avenir-Light", size: 32)
        }
    }
    
}
