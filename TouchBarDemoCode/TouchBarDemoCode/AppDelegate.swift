//
//  AppDelegate.swift
//  TouchBarDemoCode
//
//  Created by Razvan Bunea on 30/11/2016.
//  Copyright © 2016 Razvan Bunea. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if #available(OSX 10.12.1, *) {
            NSApplication.shared().isAutomaticCustomizeTouchBarMenuItemEnabled = true
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

