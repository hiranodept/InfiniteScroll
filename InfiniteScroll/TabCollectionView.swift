//
//  TabCollectionView.swift
//  InfiniteScroll
//
//  Created by Tetsuya Hirano on 2016/11/09.
//  Copyright © 2016年 Tetsuya Hirano. All rights reserved.
//

import UIKit

final class TabCollectionView: UICollectionView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let currentOffset = contentOffset
        let contentWidth = contentSize.width
        let contentHeight = contentSize.height

        let centerOffsetX = (contentWidth - bounds.width) / 2.0
        let centerOffsetY = (contentHeight - bounds.height) / 2.0

        let distanceFromCenterX = fabsf(Float(currentOffset.x - centerOffsetX))
        let distanceFromCenterY = fabsf(Float(currentOffset.y - centerOffsetY))

        if distanceFromCenterX > Float(contentWidth / 5.0) {
            contentOffset = CGPoint(x: centerOffsetX, y: currentOffset.y)
        }

        if distanceFromCenterY > Float(contentHeight / 5.0) {
            contentOffset = CGPoint(x: currentOffset.x, y: centerOffsetY)
        }
    }
}

class TabCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var categoryLabel: UILabel!

    var selectTabFontSize = CGFloat()
    var selectTabFontColer = UIColor.black
    var nomalTabFontSize = CGFloat()
    var nomalTabFontColor = UIColor.gray

    func configure(tabTitle: String, currentTab: Bool) {
        categoryLabel.text = tabTitle

        categoryLabel.font = UIFont.boldSystemFont(ofSize: currentTab ? selectTabFontSize : nomalTabFontSize)
        categoryLabel.textColor = currentTab ? selectTabFontColer : nomalTabFontColor
        
    }
}

