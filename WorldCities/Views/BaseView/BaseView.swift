//
//  BaseView.swift
//  WorldCities
//
//  Created by Mona Qora on 1/3/20.
//  Copyright © 2020 Mona Qora. All rights reserved.
//

import UIKit

protocol BaseViewProtocol {
    func setupViewData()
    func setupErrorHandling(error: ModelError)
    func setActivityIndicator(hidden: Bool)
    
    func setupActivityIndicator(view: UIView, hidden: Bool, loadingIndicator: UIActivityIndicatorView)
    func setupAlertView(view: UIViewController, title: String, message: String, buttonTitle: String)
}

extension BaseViewProtocol {
    
    func setupViewData() {
        
    }
    
    func setupErrorHandling(error: ModelError) {
        
    }
    
    func setActivityIndicator(hidden: Bool) {
        
    }
    
    func setupAlertView(view: UIViewController, title: String, message: String, buttonTitle: String) {
            let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: buttonTitle, style: .cancel, handler: nil))
        DispatchQueue.main.async {
            view.present(alertView, animated: true, completion: nil)
        }
    }
    
    func setupActivityIndicator(view: UIView, hidden: Bool, loadingIndicator: UIActivityIndicatorView) {
        if hidden {
            loadingIndicator.removeFromSuperview()
            DispatchQueue.main.async {
                loadingIndicator.stopAnimating()
            }
        }
        else {

            let center = CGPoint(x: UIScreen.main.bounds.size.width/2.0, y: UIScreen.main.bounds.size.height/2.0)
            loadingIndicator.center = center
            
            loadingIndicator.autoresizingMask = (UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.RawValue(UInt8(UIView.AutoresizingMask.flexibleRightMargin.rawValue) | UInt8(UIView.AutoresizingMask.flexibleLeftMargin.rawValue) | UInt8(UIView.AutoresizingMask.flexibleBottomMargin.rawValue) | UInt8(UIView.AutoresizingMask.flexibleTopMargin.rawValue))))

            view.addSubview(loadingIndicator)
            DispatchQueue.main.async {
                loadingIndicator.startAnimating()
            }
        }
    }
}
