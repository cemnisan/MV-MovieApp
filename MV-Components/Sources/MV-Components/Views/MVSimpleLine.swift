//
//  File.swift
//  
//
//  Created by Cem Nisan on 16.05.2022.
//

import UIKit

public class MVSimpleLine: UIView {
    
    override public init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 480, height: 320))
        backgroundColor = .systemGray
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setLineWidth(4.0)
        context.setStrokeColor(UIColor.darkGray.cgColor)
        context.move(to: CGPoint(x: 40, y: 40))
        context.addLine(to: CGPoint(x: 280, y: 300))
        context.strokePath()
    }
}
