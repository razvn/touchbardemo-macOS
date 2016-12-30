//
//  MyWindow.swift
//  TouchBarDemo
//
//  Created by Razvan Bunea on 26/11/2016.
//  Copyright © 2016 Razvan Bunea. All rights reserved.
//

import SpriteKit

@available(OSX 10.12.2, *)
class MySpriteView: SKView {
    
    let pauseNotification = Notification.Name("PauseNotificationId")
    let swipeNotification = Notification.Name("SwipeNotificationId")
    
    var startX = 0
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(with event: NSEvent) {
        //Swift.print("begin", event)
        if let touch = event.touches(matching: .began, in: self).first, touch.type == .direct {
            let location = touch.location(in: self)
            startX = Int(location.x)
            //Swift.print("Start", location)
        }

        
    }
    
    override func touchesEnded(with event: NSEvent) {
        //Swift.print("end", event)
        if let touch = event.touches(matching: .ended, in: self).first, touch.type == .direct {
            let location = touch.location(in: self)
            let endX = Int(location.x)
            //Swift.print("Ended: start:", startX, "end:",endX)
            
            if abs(endX - startX) > 5 {
                NotificationCenter.default.post(name: swipeNotification, object: event)
                //Swift.print("Pause")
            } else {
                NotificationCenter.default.post(name: pauseNotification, object: event)
                //Swift.print("Swipe")
            }
        }
        
    }

}
