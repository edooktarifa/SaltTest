//
//  DynamicHeightCollectionView.swift
//  SaltTest
//
//  Created by Phincon on 21/09/22.
//

import Foundation
import UIKit

class DynamicHeightCollectionView: UICollectionView {
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        if bounds.size != intrinsicContentSize {
            
            self.invalidateIntrinsicContentSize()
            
        }
    }
    
    override var intrinsicContentSize: CGSize {
        
        return collectionViewLayout.collectionViewContentSize
        
    }
    
}
