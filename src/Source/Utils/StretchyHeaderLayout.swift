import UIKit

final class StretchyHeaderLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElements(in: rect)
        
        layoutAttributes?.forEach { attributes in
            if attributes.representedElementKind == UICollectionView.elementKindSectionHeader &&
                attributes.indexPath.section == 0 {
                guard let collectionView = collectionView else {
                    return
                }
                
                let contentOffsetY = collectionView.contentOffset.y
                
                if contentOffsetY > 0 {
                    return
                }
                
                attributes.frame = CGRect(x: 0,
                                          y: contentOffsetY,
                                          width: collectionView.frame.width,
                                          height: attributes.frame.height - contentOffsetY)
            }
        }
        return layoutAttributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
