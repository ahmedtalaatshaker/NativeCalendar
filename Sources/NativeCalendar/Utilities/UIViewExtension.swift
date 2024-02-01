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
}
