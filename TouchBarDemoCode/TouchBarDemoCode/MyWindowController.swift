//
//  MyWindowController.swift
//  TouchBarDemoCode
//
//  Created by Razvan Bunea on 30/11/2016.
//  Copyright © 2016 Razvan Bunea. All rights reserved.
//

import Cocoa

class MyWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
    }
    
    //Tell the Window to use the viewController TouchBar
    @available(OSX 10.12.1, *)
    override func makeTouchBar() -> NSTouchBar? {
        guard let viewController = contentViewController as? ViewController else {
            return nil
        }
        return viewController.makeTouchBar()
    }
}
