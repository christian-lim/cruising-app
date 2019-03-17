//
//  extensionFile.swift
//  cruising-app
//
//  Created by Peter Luo on 3/16/19.
//  Copyright © 2019 Christian Lim. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController {
    
    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
}

extension UIColor {
    static var lionBlue : UIColor { return UIColor(red: 30/255.0, green: 64/255.0, blue: 123/255.0, alpha: 1.0)  }
    
    static var yellowShaded: UIColor { return UIColor(red: 234/255.0, green: 204/255.0, blue: 68/255.0, alpha: 1.0) }
    
    static var googleGreen: UIColor { return UIColor(red: 52/255.0, green: 166/255.0, blue: 103/255.0, alpha: 1.0)}
    
    static var acornGreen: UIColor { return UIColor(red: 91/255.0, green: 168/255.0 , blue: 117/255.0, alpha: 1.0)}
}
