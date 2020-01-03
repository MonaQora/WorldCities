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
    func setActivityIndicator(view: UIView, hidden: Bool, loadingIndicator: UIActivityIndicatorView, centerPoint: CGPoint)
}

extension BaseViewProtocol {
    func setActivityIndicator(view: UIView, hidden: Bool, loadingIndicator: UIActivityIndicatorView, centerPoint: CGPoint) {
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
