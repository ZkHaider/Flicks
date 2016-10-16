//
//  AlertView.swift
//  Flicks
//
//  Created by Haider Khan on 10/16/16.
//  Copyright © 2016 ZkHaider. All rights reserved.
//

import UIKit

class AlertView: UIView {
    
    /***********************************
     * Variables
     ***********************************/
    
    // Initializers
    public var message: String?
    public var style: AlertViewStyle
    
    // Constraints
    public var topConstraint: NSLayoutConstraint?
    public var bottomConstraint: NSLayoutConstraint?
    
    // Animation related
    public let alertViewAnimationDuration: Float = 0.4
    
    // Message background colors 
    public let errorMessageBackgroundColor: UIColor = UIColor(red:0.92, green:0.05, blue:0.21, alpha:1.00)
    public let successMessageBackgroundColor: UIColor = UIColor(red:0.30, green:0.69, blue:0.31, alpha:1.00)
    public let yieldMessageBackgroundColor: UIColor = UIColor(red:1.00, green:0.76, blue:0.03, alpha:1.00)

    // Text colors 
    public let textColor: UIColor = UIColor.white
    
    // Buffer for each side of the text
    let xBuffer: Int = 10
    let yBuffer: Int = 10
    
    // Status bar height
    let statusBarHeight: Int = 20
    
    // Default font size
    let titleFontSize: CGFloat = 16.0
    let fontSize: CGFloat = 14.0
    
    // Default height of the dropdown view
    let height: Int = 90
    
    // Flag to keep track of whether view is showing or not 
    private var isShowing: Bool = false
    
    /***********************************
     * Constructors
     ***********************************/
    
    // Custom init for passing in view and message
    public init( message: String?, style: AlertViewStyle) {
        self.message    = message
        self.style      = style
        
        // Get screen width 
        let screenWidth = UIScreen.main.bounds.size.width
        
        // Create a CGRect and pass into frame
        let viewFrame = CGRect(x: 0, y: -height, width: Int(screenWidth), height: height)
        
        super.init(frame: viewFrame)
        
        // Go ahead and configure subviews 
        configureSubviews();
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 5
    }

    // Required initializer
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /***********************************
     * Initialization Methods
     ***********************************/
    
    private func configureSubviews() {
        
        // Set the background
        configureBackground()
        
        // Set the title message label
        configureTitleMessageView()
        
        // Set our message label
        configureMessageView()
    }
    
    private func configureBackground() {
        
        // Set the background color based on the style
        switch style {
        case .Success:
            self.backgroundColor = successMessageBackgroundColor
            break
        case .Error:
            self.backgroundColor = errorMessageBackgroundColor
            break
        case .Yield:
            self.backgroundColor = yieldMessageBackgroundColor
            break
        }
    }
    
    private func configureTitleMessageView() {
        
        let width = Int(self.frame.width) - (2 * xBuffer)
        let height = 30
        
        // Create our CGRect for our message label 
        let titleLabelRect = CGRect(x: xBuffer, y: statusBarHeight, width: width, height: height)
        
        // Create a new label representing the message 
        let titleLabel = UILabel.init(frame: titleLabelRect)
        
        // Set our properties
        titleLabel.font = UIFont.init(name: "Arial-BoldMT", size: titleFontSize)
        titleLabel.textColor = textColor
        titleLabel.textAlignment = NSTextAlignment.center
        
        // Set the text depending on case 
        switch style {
        case .Success:
            titleLabel.text = "Success"
            break
        case .Error:
            titleLabel.text = "Error"
            break
        case .Yield:
            titleLabel.text = "Alert"
            break
        }
        
        // Add the message label to the key window in order to make it display above nav bar
        self.addSubview(titleLabel)
    }
    
    private func configureMessageView() {
        
        let y = Double(statusBarHeight) + Double(yBuffer) * 2.3
        let width = Int(self.frame.width) - (2 * xBuffer)
        let height = 40
        
        // Create our rect
        let messageLabelRect = CGRect(x: xBuffer, y: Int(y), width: width, height: height)
        
        // Create label
        let messageLabel = UILabel.init(frame: messageLabelRect)
        
        // Set our properties
        messageLabel.font = UIFont.init(name: "Arial-BoldMT", size: fontSize)
        messageLabel.textColor = textColor
        messageLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        messageLabel.numberOfLines = 2
        messageLabel.textAlignment = NSTextAlignment.center
        
        // Set the text
        messageLabel.text = message

        // Add the label
        self.addSubview(messageLabel)
        
        self.isShowing = false
    }
    
    /***********************************
     * AlertView Methods
     ***********************************/

    public func show() {
        
        // Go ahead and add self to the view
        UIApplication.shared.keyWindow?.addSubview(self)
        
        // Set our showing flag to true 
        self.isShowing = true
        
        if (isShowing) {
            animateIn()
        }
    }
    
    private func animateIn() {
        
        UIView.animateKeyframes(
            withDuration: TimeInterval(alertViewAnimationDuration),
            delay: 0,
            options: UIViewKeyframeAnimationOptions.calculationModeCubic,
            animations: {
                var frame = self.frame
                frame.origin.y = 0
                self.frame = frame
            },
            completion: { (_) -> Void in
                
                self.isShowing = false
                self.animateOut()
        })
    }
    
    private func animateOut() {
        
        UIView.animateKeyframes(
            withDuration: TimeInterval(alertViewAnimationDuration),
            delay: 0.6,
            options: UIViewKeyframeAnimationOptions.calculationModeCubic,
            animations: {
                var frame = self.frame
                frame.origin.y = -(CGFloat)(self.height)
                self.frame = frame
            },
            completion: { (_) -> Void in
                
                // Remove the view
                self.removeView()
        })

    }
    
    private func removeView() {
        if (self.isShowing) {
            self.removeFromSuperview()
        }
    }

}
