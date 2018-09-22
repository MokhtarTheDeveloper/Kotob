//
//  Kotob Button.swift
//  Kotob
//
//  Created by Mokhtar on 9/18/18.
//  Copyright © 2018 Mokhtar. All rights reserved.
//

import UIKit

class KotobButton : UIButton {
    override var isHighlighted : Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.nagwaOrange : .white
//            tintColor = isHighlighted ? .orange : .white
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
