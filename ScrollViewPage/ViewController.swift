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
    
    var images = [UIImageView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        var contentWidth: CGFloat = 0.0
        scrollView.frame = CGRect(x: view.frame.size.width/4, y: 0.0, width: view.frame.size.width/2, height: view.frame.size.height)
        
        for x in 0...2 {
            let image = UIImage(named: "icon\(x)")
            let imageView = UIImageView(image: image)
            images.append(imageView)
            
            var newX: CGFloat = 0.0
            newX = scrollView.frame.midX + scrollView.frame.size.width * CGFloat(x)
            contentWidth += scrollView.frame.size.width
            
            scrollView.addSubview(imageView)
            imageView.frame = CGRect(x: newX-150, y: view.frame.size.height/2-75, width: 150, height: 150)
        }
        
        scrollView.clipsToBounds = false
        scrollView.contentSize = CGSize(width: contentWidth, height: view.frame.size.height)
    }

}

