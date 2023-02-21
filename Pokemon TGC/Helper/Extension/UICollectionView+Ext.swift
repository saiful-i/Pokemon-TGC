//
//  UICollectionView+Ext.swift
//  Pokemon TGC
//
//  Created by Saiful Islam on 21/02/23.
//

import UIKit
import Foundation

extension UICollectionView {
    /// Register nibs faster by passing the type - if for some reason the `identifier` is different then it can be passed
    ///
    /// - Parameters:
    ///   - type: UICollectionViewCell.Type
    ///   - identifier: String?
    func registerCell(withClass: UICollectionViewCell.Type) {
        register(withClass.self, forCellWithReuseIdentifier: String(describing: withClass))
    }
    
    /// Register nibs faster by passing the type - if for some reason the `identifier` is different then it can be passed
    ///
    /// - Parameters:
    ///   - type: UICollectionViewCell.Type
    ///   - indexPath: IndexPath
    func dequeueCell<T: UICollectionViewCell>(withType type: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: type.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Error: cell with id: \(type.reuseIdentifier) for indexPath: \(indexPath) is not \(T.self)")
        }
        return cell
    }
}

public extension UICollectionReusableView {
    /// UICollectionReusableView value identifier
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
