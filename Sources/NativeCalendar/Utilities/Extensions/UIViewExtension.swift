//
//  UIViewExtension.swift
//  NativeCalendarPOC
//
//  Created by Ahmed Talaat on 01/02/2024.
//

import UIKit
extension UIView {
    @discardableResult
    func fromNib<T: UIView>(viewType: T.Type, frombunde : Bundle? = nil) -> UIView? {
        let nibName = String(describing: viewType)
        guard let bundleName = frombunde else { return nil}
        guard let view = bundleName.loadNibNamed(nibName, owner: self, options: nil)?.first as? UIView else {
            fatalError("Failed to instantiate nib \(nibName)")
        }
        self.addSubview(view)
        view.frame = self.bounds
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        return view
    }
    
    func roundedCorner(cornerRadii: CGFloat, corners: CACornerMask) {
        layer.cornerRadius = cornerRadii
        layer.masksToBounds = true
        self.layer.maskedCorners = corners
    }
    
    func roundedBorders(
        radius: CGFloat,
        borderColor: UIColor = UIColor.clear,
        borderWidth: CGFloat = 0
    ) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        self.clipsToBounds = true
    }
    
    func applyDropShadow(
        radius: CGFloat,
        opacity: Float = 0.3,
        color: UIColor = .black.withAlphaComponent(0.8),
        shadowOffset: CGSize = CGSize(width: -1, height: 1)
    ) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = radius
        layer.shouldRasterize = true
        layer.rasterizationScale = true ? UIScreen.main.scale : 1
    }
    
    func setGradientBackground(colors: [CGColor]) {
        if colors.count == 1 {
            self.backgroundColor = UIColor(cgColor: colors[0])
            return
        }
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.locations = [0.0, 1.0]
        
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at:0)
    }

}
