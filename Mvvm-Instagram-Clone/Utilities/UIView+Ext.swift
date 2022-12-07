//
//  UIView+Ext.swift
//  Mvvm-Instagram-Clone
//
//  Created by Akın Çetin on 5.12.2022.
//

import UIKit

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?,
                bottom: NSLayoutYAxisAnchor?,
                leading: NSLayoutXAxisAnchor?,
                trailing: NSLayoutXAxisAnchor?,
                height: CGFloat?,
                width: CGFloat?,
                paddingTop: CGFloat,
                paddingLeft: CGFloat,
                paddingRight: CGFloat,
                paddingBottom: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leading, constant: paddingLeft).isActive = true
        }
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: trailing, constant: paddingRight).isActive = true
        }
        if height != nil {
            self.heightAnchor.constraint(equalToConstant: CGFloat(height!)).isActive = true
        }
        if width != nil {
            self.widthAnchor.constraint(equalToConstant: CGFloat(width!)).isActive = true
        }
        
    }
    
}
