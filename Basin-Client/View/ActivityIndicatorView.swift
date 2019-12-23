//
//  UIViewController+ShowSpinner.swift
//  Conflux-Client
//
//  Created by Zaccari Silverman on 6/25/19.
//  Copyright © 2019 macosten. All rights reserved.
//

import UIKit

class ActivityIndicatorView: UIView {
    
    //If this needs to be remade, just do it in a XIB.

    var coveringView: UIView

    let messageLabel = UILabel()
    
    let stackView = UIStackView()
    let curtain = UIView() //This is the background layer over the view we're obstructing
    let activityIndicator = UIActivityIndicatorView(style: .gray)
    
    init(coveringView: UIView, withMessage message: String){
        self.coveringView = coveringView //We'll want to keep track of this anyway.
        
        super.init(frame: coveringView.frame) //super.init with the frame of the view we're covering.

        //Configure the message label.
        messageLabel.text = message
        messageLabel.textColor = UIColor.white
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0 //Try not to go too crazy with the message length.
        messageLabel.lineBreakMode = .byWordWrapping
        
        //Configure the stack-view so that it is centered and aligns the label and activity indicator
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.addArrangedSubview(activityIndicator)
        stackView.addArrangedSubview(messageLabel)
        
        //Configure the curtain.
        curtain.frame = coveringView.frame
        curtain.center = coveringView.center
        curtain.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
        curtain.clipsToBounds = true
        
        //Center the curtain.
        stackView.center = curtain.center
    
        //Add the subviews, where appropriate.
        curtain.addSubview(stackView)
        coveringView.addSubview(curtain)
        
        //Start animating as soon as we can be seen.
        activityIndicator.startAnimating()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil //Unimplemented.
    }
    
    //Updates the message displayed by the view.
    func updateMessage(newMessage: String){
        self.messageLabel.text = newMessage
    }
    
    //Gets rid of the view.
    func stop(){
        activityIndicator.stopAnimating()
        superview?.willRemoveSubview(self)
        curtain.removeFromSuperview()
        self.removeFromSuperview()
    }
    
}
