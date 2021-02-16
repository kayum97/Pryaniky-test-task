//
//  UIViewControllerExtensions.swift
//  test-task
//
//  Created by Admin on 15.02.2021.
//

import Foundation
import UIKit

extension UIViewController {
    func showSimpleAlert(title: String?, message: String?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
}
