//
//  TableViewHeader.swift
//  Kotob
//
//  Created by Mokhtar on 9/22/18.
//  Copyright © 2018 Mokhtar. All rights reserved.
//

import UIKit


class TableViewHeader : UIView {
    
    let headerTitle = UILabel()
    
    lazy var moreButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "more"), for: .normal)
        button.setTitle("الكل", for: .normal)
        button.semanticContentAttribute = .forceLeftToRight
        button.tintColor = .black
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        UIView.appearance().semanticContentAttribute = .forceRightToLeft
        setUpViews()
        backgroundColor = UIColor(r: 243, g: 245, b: 248)
        alpha = 0.97
    }
    
    
    fileprivate func setUpViews() {
        addSubview(headerTitle)
        addSubview(moreButton)
        headerTitle.setupXYAnchors(leading: leadingAnchor,centerY: centerYAnchor, leadingConstant: 15)
        headerTitle.widthAnchor.constraint(equalToConstant: 100).isActive = true
        headerTitle.heightAnchor.constraint(equalToConstant: 44).isActive = true
        moreButton.setupXYAnchors(trailing: trailingAnchor, centerY: centerYAnchor, trailingConstant: -15)
        moreButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
        moreButton.heightAnchor.constraint(equalToConstant: 34).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
