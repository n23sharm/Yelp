//
//  SortViewController.swift
//  Yelp
//
//  Created by Neha Sharma on 5/17/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol SortViewControllerDelegate {
    optional func sortViewController(sortViewController : SortViewController, sortClicked sort: Int)
}

class SortViewController: UIViewController {
    
    weak var delegate: SortViewControllerDelegate?

    @IBOutlet weak var bestMatchedButton: UIButton!
    @IBOutlet weak var distanceButton: UIButton!
    @IBOutlet weak var highestRatedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func bestMatchedClicked(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        delegate?.sortViewController?(self, sortClicked: 0)
    }

    @IBAction func distanceClicked(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        delegate?.sortViewController?(self, sortClicked: 1)

    }
    
    @IBAction func highestRatedClicked(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        delegate?.sortViewController?(self, sortClicked: 2)

    }
    
}
