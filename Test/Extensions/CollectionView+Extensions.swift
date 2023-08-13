//
//  CollectionView+Extensions.swift
//  Test
//
//  Created by Adam Wareing on 12/8/2023.
//

import UIKit

public extension UICollectionView {
    
    // MARK: Cells
    
    func register<T: UICollectionViewCell>(_ cell: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Cell isn't registered on the UICollectionView")
        }
        return cell
    }
}

extension UICollectionViewCell {
    
    static var reuseIdentifier: String { return String(describing: self) }
}
