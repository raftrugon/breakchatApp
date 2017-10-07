//
//  ShadowView.swift
//  Breakpoint
//
//  Created by rafa on 23/8/17.
//  Copyright © 2017 rafa trujillo. All rights reserved.
//

import UIKit

class ShadowView: UIView {
    
    override func awakeFromNib() {
        self.layer.shadowOpacity = 0.75
        self.layer.shadowRadius = 5
        self.layer.shadowColor = UIColor.black.cgColor
        super.awakeFromNib()
    }
    
}
