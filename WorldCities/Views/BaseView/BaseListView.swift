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
    
    func setupActivityIndicator(view: UIView, hidden: Bool, loadingIndicator: UIActivityIndicatorView, centerPoint: CGPoint)
    func setupAlertView(view: UIViewController, title: String, message: String, buttonTitle: String)
}

extension BaseViewProtocol {
    
    func setupAlertView(view: UIViewController, title: String, message: String, buttonTitle: String) {
            let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: buttonTitle, style: .cancel, handler: nil))
        DispatchQueue.main.async {
            view.present(alertView, animated: true, completion: nil)
        }
    }
    
    func setActivityIndicator(hidden: Bool) {
        
    }
    
    func setupActivityIndicator(view: UIView, hidden: Bool, loadingIndicator: UIActivityIndicatorView, centerPoint: CGPoint) {
        if hidden {
            loadingIndicator.removeFromSuperview()
            DispatchQueue.main.async {
                loadingIndicator.stopAnimating()
            }
        }
        else {
            loadingIndicator.center = centerPoint
            view.addSubview(loadingIndicator)
            DispatchQueue.main.async {
                loadingIndicator.startAnimating()
            }
        }
    }
}
