//
//  MonWindowController.swift
//  TouchBarDemo
//
//  Created by Razvan Bunea on 25/11/2016.
//  Copyright © 2016 Razvan Bunea. All rights reserved.
//

import Cocoa

@available(OSX 10.12.2, *)
class MyWindowController: NSWindowController {

    @IBOutlet weak var myTouchBar: NSTouchBar!
    @IBOutlet weak var colorPicker: NSColorPickerTouchBarItem!
    
    
    @IBAction func sayHi(_ sender: Any) {
        print("Hi from touch bar")
    }


    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        colorPicker.isEnabled = true
        colorPicker.target = self
        colorPicker.action = #selector(colorPicked)
        
    }

    func colorPicked() {
        print(colorPicker.color)
        self.contentViewController?.view.layer?.backgroundColor = colorPicker.color.cgColor
    }
}
