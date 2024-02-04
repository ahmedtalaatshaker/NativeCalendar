//
//  CoreManager.swift
//  
//
//  Created by Ahmed Talaat on 04/02/2024.
//

import Foundation
public class CoreManager {
    public static func getFrameworkBundle<T>(viewType: T.Type) -> Bundle {
#if SWIFT_PACKAGE
        return Bundle.module
#else
        return Bundle(for: viewType.self as! AnyClass)
#endif
    }
}
