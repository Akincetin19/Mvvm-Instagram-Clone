//
//  UIViewController+Ext.swift
//  Mvvm-Instagram-Clone
//
//  Created by Akın Çetin on 6.12.2022.
//

import Foundation
import UIKit

extension UIViewController {
    func makeAlert(view: UIViewController, error: Error) {
        let dialogMessage = UIAlertController(title: "Hata", message: error.localizedDescription, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Tamam", style: .default)
        dialogMessage.addAction(ok)
        view.present(dialogMessage, animated: true, completion: nil)
    }
}
