//
//  UIAlertController.swift
//  MarvelHeroes
//
//  Created by gustavo r meyer on 8/13/17.
//  Copyright © 2017 gustavo r meyer. All rights reserved.
//

import UIKit

extension UIAlertController {

    public class func showAlert(title: String? = nil, message: String? = nil, inViewController viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    public class func showWarning(message: String? = nil, inViewController viewController: UIViewController) {
        UIAlertController.showAlert(title: NSLocalizedString("Alert", comment: ""),message:message, inViewController: viewController)
    }
    
    public class func showError(message: String? = nil, inViewController viewController: UIViewController) {
        UIAlertController.showAlert(title: NSLocalizedString("Error", comment: ""),message:message, inViewController: viewController)
    }
    
}
