//
//  ViewController.swift
//  TouchBarDemoCode
//
//  Created by Razvan Bunea on 30/11/2016.
//  Copyright © 2016 Razvan Bunea. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var representedObject: Any? {
        didSet {
        }
    }
}

//Set the Touch Bar identifier
fileprivate extension NSTouchBarCustomizationIdentifier {
    static let customTouchBar = NSTouchBarCustomizationIdentifier("net.razvan.macos.touchbar.customTouchBar")
}

//Set the Touch Bar items identifiers
fileprivate extension NSTouchBarItemIdentifier {
    static let helloItem = NSTouchBarItemIdentifier("net.razvan.macos.touchbar.items.helloItem")
    static let imageItem = NSTouchBarItemIdentifier("net.razvan.macos.touchbar.items.imageItem")
    static let okItem = NSTouchBarItemIdentifier("net.razvan.macos.touchbar.items.okItem")
}


@available(OSX 10.12.2, *)
extension ViewController: NSTouchBarDelegate {
    
    //Build the touchbar
    override func makeTouchBar() -> NSTouchBar? {
        //Create TouchBar
        let touchBar = NSTouchBar()
        touchBar.delegate = self
        //affect the bar identifier
        touchBar.customizationIdentifier = .customTouchBar
        //affect the default items and order them in the touch bar
        touchBar.defaultItemIdentifiers = [.helloItem, .flexibleSpace,.imageItem, .flexibleSpace, .okItem]
        //items allowed for customization
        touchBar.customizationAllowedItemIdentifiers = [.helloItem, .imageItem, .okItem, .characterPicker]
        
        return touchBar
    }
    
    //NSTouchBarDelegate - method
    //creates the custom items
    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItemIdentifier) -> NSTouchBarItem? {
        switch identifier {
        case NSTouchBarItemIdentifier.helloItem:
            let customViewItem = NSCustomTouchBarItem(identifier: identifier)
            customViewItem.view = NSButton(title: "Hello", target: self, action: #selector(sayHello))
            return customViewItem
        case NSTouchBarItemIdentifier.okItem:
            let okItem = NSCustomTouchBarItem(identifier: identifier)
            let button = NSButton(title: "OK", target: self, action: #selector(sayOk))
            button.bezelColor = NSColor(red:0.35, green:0.61, blue:0.35, alpha:1.00)
            okItem.view = button
            return okItem
        case NSTouchBarItemIdentifier.imageItem:
            let viewItem = NSCustomTouchBarItem(identifier: identifier)
            let image = NSImageView(image: NSImage(named: "nyan1")!)
            viewItem.view = image
            return viewItem
        default:
            return nil
        }
    }
    
    func sayHello() {
        print("Hello from Touch Bar")
    }
    
    func sayOk() {
        print("Ok from Touch Bar")
    }
}

