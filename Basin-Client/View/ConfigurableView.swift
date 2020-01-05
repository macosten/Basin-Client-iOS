//
//  RoundedVi.swift
//  Basin-Client
//
//  Created by Zaccari Silverman on 1/4/20.
//  Copyright © 2020 macosten. All rights reserved.
//

import UIKit

///A better name for this file/class might be a good idea, but I can't think of one.
@IBDesignable class ConfigurableView : UIView {
    
    @IBInspectable var borderColor: UIColor = .white {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat = 1.0
        {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 0.0 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0.0 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0.0, height: 0.0) {
        didSet {
            layer.shadowOffset = shadowOffset
        }
    }
    
}
