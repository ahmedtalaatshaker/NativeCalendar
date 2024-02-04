//
//  File.swift
//  
//
//  Created by Ahmed Talaat on 04/02/2024.
//

import UIKit

extension UICollectionView {
    public func registerReusableCell<T: UICollectionViewCell>(_ cells: T.Type) where T: ReusableView {
        if let nib = T.nib {
            register(nib, forCellWithReuseIdentifier: T.reusableIdentifier)
        } else {
            register(T.self, forCellWithReuseIdentifier: T.reusableIdentifier)
        }
    }
}
