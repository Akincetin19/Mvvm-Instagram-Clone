//
//  UITextField+Ext.swift
//  Mvvm-Instagram-Clone
//
//  Created by Akın Çetin on 5.12.2022.
//

import UIKit

extension UITextField {
    func configureTextField(subView: UITextField ,placeHolder: String) {
        subView.borderStyle = .roundedRect
        subView.backgroundColor = UIColor(white: 0, alpha: 0.05)
        subView.placeholder = placeHolder
    }
}
