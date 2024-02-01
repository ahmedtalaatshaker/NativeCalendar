//
//  UIViewExtension.swift
//  NativeCalendarPOC
//
//  Created by Ahmed Talaat on 01/02/2024.
//

import UIKit
extension UIView {
    @discardableResult
    public func fromNib<T: UIView>(type: T.Type) -> UIView? {
        let nibName = String(describing: type)
        guard let view = Bundle(for: type).loadNibNamed(nibName, owner: self, options: nil)?.first as? UIView else {
            return nil
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

}
