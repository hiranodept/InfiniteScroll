//
//  PageViewController.swift
//  InfiniteScroll
//
//  Created by Tetsuya Hirano on 2016/11/09.
//  Copyright © 2016年 Tetsuya Hirano. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    var currentIndex: Int = 0
    let max = 4
    private func backgroundColor() -> UIColor {
        let colors = [UIColor.blue, UIColor.cyan, UIColor.black, UIColor.brown]
        return colors[currentIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if currentIndex == 0 {
            currentIndex = max - 1
        } else {
            currentIndex = currentIndex - 1
        }
        let vc = makeViewController()
        return vc
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if currentIndex == max - 1 {
            currentIndex = 0
        } else {
            currentIndex = currentIndex + 1
        }
        let vc = makeViewController()
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let viewControllers = [makeViewController()]
        setViewControllers(viewControllers, direction: .forward, animated: true)
        dataSource = self
        delegate = self
    }

    private func makeViewController()-> UIViewController {
        let vc = UIViewController()
        vc.view.backgroundColor = backgroundColor()
        return vc
    }
}
