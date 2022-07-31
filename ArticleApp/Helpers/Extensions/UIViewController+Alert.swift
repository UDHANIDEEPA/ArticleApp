//
//  UIViewController+Alert.swift
//  ArticleApp
//
//  Created by Vanshika on 31/07/2022.
//

import UIKit

extension UIViewController {
    func showDefaultAlert(title: String?, message: String?, actionTitle: String?, actionBlock:(() -> Void)?, cancelActionTitle: String?, cancelActionBlock:(() -> Void)? = nil) {
        
        DispatchQueue.main.async { [weak self] in
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let action = UIAlertAction(title: actionTitle, style: .default) { _ in
                alertController.dismiss(animated: true)
                actionBlock?()
            }
            alertController.addAction(action)

            if cancelActionTitle !=  nil {
                let cancelAction = UIAlertAction(title: cancelActionTitle, style: .default) { _ in
                    alertController.dismiss(animated: true)
                    cancelActionBlock?()
                }
                alertController.addAction(cancelAction)
            }
            
            self?.present(alertController, animated: true)
        }
    }
}
