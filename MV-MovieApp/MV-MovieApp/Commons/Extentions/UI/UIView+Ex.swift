//
//  UIView+ex.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 9.05.2022.
//

import UIKit

typealias layoutXAxis = (NSLayoutXAxisAnchor, CGFloat)
typealias layoutYAxis = (NSLayoutYAxisAnchor, CGFloat)

extension UIView {
    
    func addSubviews(views: UIView...) {
        views.forEach { addSubview($0) }
    }
    
    func pinToEdges(of superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
          
        topAnchor.constraint(equalTo: superView.topAnchor).isActive           = true
        leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive   = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive     = true
    }
    
    func configureConstraints(top: layoutYAxis?      = nil,
                              leading: layoutXAxis?  = nil,
                              trailing: layoutXAxis? = nil,
                              bottom: layoutYAxis?   = nil,
                              centerX: layoutXAxis?  = nil,
                              centerY: layoutYAxis?  = nil) {
        if let top = top {
            topAnchor.constraint(equalTo: top.0, constant: top.1).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading.0, constant: leading.1).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing.0, constant: trailing.1).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom.0, constant: bottom.1).isActive = true
        }
        
        if let centerX = centerX {
            centerXAnchor.constraint(equalTo: centerX.0, constant: centerX.1).isActive = true
        }
        
        if let centerY = centerY {
           centerYAnchor.constraint(equalTo: centerY.0, constant: centerY.1).isActive = true
        }
    }
    
    func configureWidth(width: CGFloat) {
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func configureHeight(height: CGFloat) {
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
}
