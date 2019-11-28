//
//  Extention.swift
//  AlamofireDemo
//
//  Created by Dheeraj Arora on 25/11/19.
//  Copyright © 2019 Dheeraj Arora. All rights reserved.
//

import Foundation
import  UIKit

extension UIViewController {
    
    func startActivityIndicator(withMsg: String, onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let spIntialView = UIView.init(frame: CGRect(x: onView.frame.size.width/2, y: onView.frame.size.height/2, width: 120, height: 120))
        spIntialView.center = spinnerView.center
        spIntialView.backgroundColor = UIColor.darkGray
        spIntialView.layer.cornerRadius = 10
        spIntialView.layer.masksToBounds = true
        let label = UILabel.init(frame: CGRect(x: 0, y: 85, width: 120, height: 20))
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        label.textAlignment = NSTextAlignment.center
        label.text = withMsg
        let ai = UIActivityIndicatorView.init(frame: CGRect(x: 45, y: 45, width: 30, height: 30))
        ai.style = .whiteLarge
        ai.startAnimating()
        
        DispatchQueue.main.async {
            spinnerView.addSubview(spIntialView)
            spIntialView.addSubview(ai)
            spIntialView.addSubview(label)
            onView.addSubview(spinnerView)
        }
        
    }
    func stopActivityIndicator(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.subviews.last?.removeFromSuperview()
        }
   }
    
    func showAlertMessage(title:String, message: String)   {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel) { (action) in
        }
        alert.addAction(closeAction)
        self.present(alert, animated: true, completion: nil)
    }
}

