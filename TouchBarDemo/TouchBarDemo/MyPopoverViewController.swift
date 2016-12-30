//
//  MyPopoverViewController.swift
//  TouchBarDemo
//
//  Created by Razvan Bunea on 25/11/2016.
//  Copyright © 2016 Razvan Bunea. All rights reserved.
//

import Cocoa
import SpriteKit

@available(OSX 10.12.2, *)
class MyPopoverViewController: NSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let animView = MySpriteView(frame: self.view.bounds)
        
        let scene = MyScene()
        self.view = animView
        
        
        animView.presentScene(scene)
    }
}
