//
//  UIViewController+ NVActivityIndicatorView.swift
//  MarvelHeros
//
//  Created by gustavo r meyer on 8/13/17.
//  Copyright © 2017 gustavo r meyer. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

extension UIViewController:NVActivityIndicatorViewable{
    
    func showActivityIndicatory() {
        NVActivityIndicatorView.DEFAULT_TYPE = .pacman
        NVActivityIndicatorView.DEFAULT_COLOR = UIColor.red
        let activityData = ActivityData()
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    }
    
    func hideActivityIndicatory() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
}

