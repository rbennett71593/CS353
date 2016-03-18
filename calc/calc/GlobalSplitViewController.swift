//
//  GlobalSplitViewController.swift
//  calc
//
//  Created by Ryan Bennett on 3/15/16.
//  Copyright © 2016 bennry01. All rights reserved.
//

import Foundation

//GlobalSplitViewController.swift

import UIKit

class GlobalSplitViewController: UISplitViewController, UISplitViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
    }
    
    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController, ontoPrimaryViewController primaryViewController: UIViewController) -> Bool{
        return true
    }
    
}