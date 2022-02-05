//
//  Extensions.swift
//  PhotoGalleryApp
//
//  Created by Algazzar on 04/02/2022.
//

import Foundation
import UIKit

//MARK: - collection view extensions
extension UICollectionView {
    
    func registerCellNib<Cell: UICollectionViewCell>(cellClass: Cell.Type){
        register(UINib(nibName: String(describing: Cell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: Cell.self))
    }
    
    
    func dequeue<Cell: UICollectionViewCell>(indexPath: IndexPath) -> Cell{
        
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: Cell.self), for: indexPath) as? Cell else {
            fatalError("Error in cell")
        }
        return cell
    }
}

//MARK: - string extensions
extension String {
    
    var safeUrl: String{
        get{
            return addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        }
    }
}

//MARK: - viewController extensions
extension UIViewController: UIPopoverPresentationControllerDelegate{
    
    // instantiate view controller from nib
    static func instantiateFromNib() -> Self {
        func loadFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }
        
        return loadFromNib()
    }
}
