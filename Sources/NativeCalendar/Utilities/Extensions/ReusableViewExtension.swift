//
//  File.swift
//  
//
//  Created by Ahmed Talaat on 04/02/2024.
//

import UIKit

public protocol ReusableView: AnyObject {
    static var reusableIdentifier: String { get }
    static var nib: UINib? { get }
}

public extension ReusableView where Self: UIView {

    static var reusableIdentifier: String { return String(describing: self) }
    static var nib: UINib? {
         if Bundle.init(for: Self.self).path(forResource: String(describing: self), ofType: "nib") != nil {
            return UINib(nibName: String(describing: self), bundle: Bundle.init(for: Self.self))
         }else if (CoreManager.getFrameworkBundle(viewType: Self.self).path(forResource: String(describing: self), ofType: "nib")) != nil {
             return UINib(nibName: String(describing: self), bundle: CoreManager.getFrameworkBundle(viewType: Self.self))
        }else {
            return nil
        }
    }
}
