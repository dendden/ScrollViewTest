//
//  ViewController.swift
//  ScrollViewPage
//
//  Created by Денис Трясунов on 10/24/16.
//  Copyright © 2016 Денис Трясунов. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    let rightSwipe = UISwipeGestureRecognizer()
    let leftSwipe = UISwipeGestureRecognizer()
    
    var images = [UIImageView]()
    var contentWidth: CGFloat = 0.0
    var scrollWidth: CGFloat = 0.0
    var scrollHeight: CGFloat = 0.0
    var newX: CGFloat = 0.0
    let MAX_PAGE = 2
    let MIN_PAGE = 0
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rightSwipe.direction = .right
        leftSwipe.direction = .left
        
        rightSwipe.addTarget(self, action: #selector(self.detectSwipe(sender:)))
        leftSwipe.addTarget(self, action: #selector(self.detectSwipe(sender:)))
        
        view.addGestureRecognizer(rightSwipe)
        view.addGestureRecognizer(leftSwipe)
        
        view.isUserInteractionEnabled = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        scrollWidth = scrollView.frame.size.width
        scrollHeight = scrollView.frame.size.height
        
        for x in 0...2 {
            let image = UIImage(named: "icon\(x)")
            let imageView = UIImageView(image: image)
            images.append(imageView)
            
            newX = calculateNewX(scrollWidth: scrollWidth, imageIndex: x)
            contentWidth += scrollWidth
            
            scrollView.addSubview(imageView)
            imageView.frame = CGRect(x: newX-75, y: scrollHeight/2-75, width: 150, height: 150)
        }
        
        images[currentPage].transform = CGAffineTransform.init(scaleX: 1.2, y: 1.2)
        
        scrollView.clipsToBounds = false
        scrollView.contentSize = CGSize(width: contentWidth, height: scrollView.frame.size.height)
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        scrollWidth = scrollView.frame.size.width
        scrollHeight = scrollView.frame.size.height
        
        var index = 0
        for imageView in scrollView.subviews {
            newX = calculateNewX(scrollWidth: scrollWidth, imageIndex: index)
            imageView.frame = CGRect(x: newX-75, y: scrollHeight/2-75, width: 150, height: 150)
            index += 1
        }
    }
    
    func calculateNewX(scrollWidth: CGFloat, imageIndex: Int) -> CGFloat {
        return scrollWidth / 2 + scrollWidth * CGFloat(imageIndex)
    }
    
    func detectSwipe(sender: UISwipeGestureRecognizer) {
        if currentPage < MAX_PAGE && sender.direction == UISwipeGestureRecognizerDirection.left {
            moveScrollView(direction: 1)
        }
        
        if currentPage > MIN_PAGE && sender.direction == UISwipeGestureRecognizerDirection.right {
            moveScrollView(direction: -1)
        }
    }
    
    func moveScrollView(direction: Int) {
        currentPage += direction
        print("currentPage = \(currentPage)")
        let point = CGPoint(x: scrollWidth * CGFloat(currentPage), y: 0.0)
        scrollView.setContentOffset(point, animated: true)
        
        UIView.animate(withDuration: 0.4) {
            self.images[self.currentPage].transform = CGAffineTransform.init(scaleX: 1.2, y: 1.2)
            print("transformed image # \(self.currentPage)")
            
            for x in 0..<self.images.count {
                if x != self.currentPage {
                    self.images[x].transform = CGAffineTransform.identity
                }
            }
        }
    }

}

