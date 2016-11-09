//
//  ViewController.swift
//  InfiniteScroll
//
//  Created by Tetsuya Hirano on 2016/11/09.
//  Copyright © 2016年 Tetsuya Hirano. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabSize = [0,0,0,0,0,0,0]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var currentTabIndex: Int = 0
    var tabSize: [CGFloat] = []

    @IBOutlet weak var collectionView: TabCollectionView!
    var selectTabFontSize: CGFloat = 21.0
    var selectTabFontColor = UIColor.black
    var nomalTabFontSize: CGFloat = 17.0
    var nomalTabFontColor = UIColor.gray
    var cellPaddingSize: CGFloat = 14.0
    var cellheight:CGFloat = 44.0

    var tabs = ["おすすめ", "ビューティー", "フィットネス", "グルメ", "ライフハック", "レシピ", "スタイル"]

    //==============================================================================
    // MARK: UICollectionViewDataSource indispensable
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabs.count * 5 //5倍にする
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TabCollectionViewCell", for: indexPath) as! TabCollectionViewCell

        cell.selectTabFontSize = selectTabFontSize
        cell.selectTabFontColer = selectTabFontColor
        cell.nomalTabFontSize = nomalTabFontSize
        cell.nomalTabFontColor = nomalTabFontColor
        
        cell.configure(tabTitle: tabs[indexPath.row % tabs.count],
                       currentTab: (indexPath.row % tabs.count) == currentTabIndex)

        return cell

    }

    //==============================================================================
    // MARK: UICollectionViewDelegateFlowLayout
    //cellのサイズを返す　Tab幅を文字数にあわせている
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        var fontSize = nomalTabFontSize
        if currentTabIndex == indexPath.row {
            fontSize = selectTabFontSize
        }

        let label = UILabel(frame: CGRect(origin: CGPoint(x:0, y:0), size: CGSize(width: 0, height: fontSize)))
        label.font = UIFont.boldSystemFont(ofSize: fontSize)
        label.text = tabs[indexPath.row % tabs.count]
        label.sizeToFit()
        let size = CGSize(width: label.bounds.width + cellPaddingSize * 2, height: cellheight)
        tabSize[indexPath.row % tabs.count] = size.width
        return size
    }

    func snapToNearestCell(scrollView: UIScrollView) {
        var distance: CGFloat = 0
        for i in 0..<collectionView.numberOfItems(inSection: 0) {
            let cellWidth = tabSize[i % tabs.count]
            distance += cellWidth
            if scrollView.contentOffset.x <= distance - cellWidth/2 {
                 let indexPath = IndexPath(item: i, section: 0)
                collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
                break
            }
        }
    }

    //==============================================================================
    // MARK: scrollview delegate
    //==============================================================================
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        snapToNearestCell(scrollView: scrollView)
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        snapToNearestCell(scrollView: scrollView)
    }
}

