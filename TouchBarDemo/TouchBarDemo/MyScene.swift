//
//  MyScene.swift
//  TouchBarDemo
//
//  Created by Razvan Bunea on 26/11/2016.
//  Copyright © 2016 Razvan Bunea. All rights reserved.
//

import SpriteKit

class MyScene: SKScene {
    var cat: SKSpriteNode!
    var rainbow: SKSpriteNode!
    var backgrounds: [SKSpriteNode] = []
    let pauseNotification = Notification.Name("PauseNotificationId")
    let swipeNotification = Notification.Name("SwipeNotificationId")
    
    let defVelocity: CGFloat = 300
    var moveRight = true
    var catVelocity: CGFloat {
        get {
            if self.moveRight {
                return self.defVelocity
            } else {
                return (-1 * self.defVelocity)
            }
        }
    }
}

extension MyScene {
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        self.view?.acceptsTouchEvents = true
        self.size = view.frame.size
        self.backgroundColor = .black
        self.scaleMode = .resizeFill
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.pauseAction), name: pauseNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.swipeAction), name: swipeNotification, object: nil)
        let cat = self.createCat()
        self.cat = cat
        self.addChild(self.cat)
        
        self.createRainbows()
        self.createBackground()
        
    }
    
    override func didFinishUpdate() {
        super.didFinishUpdate()
        
        self.cat.physicsBody?.velocity.dx = self.catVelocity
        
        //self.camera?.position.x = self.cat.position.x
        if self.cat.position.x > self.frame.width + self.cat.frame.width {
            self.cat.position.x = -30
        }
        
        if self.cat.position.x < -self.cat.frame.width {
            self.cat.position.x = self.frame.width + self.cat.frame.width
        }
        
        
        //hide rainbows that are in front of the cat (depends on cat's direction)
        self.enumerateChildNodes(withName: "rainbow") {
            (node, stop) in
            if self.moveRight {
                if node.frame.maxX > self.cat.frame.midX {
                    node.isHidden = true
                } else {
                    node.isHidden = false
                }
            } else {
                if node.frame.maxX < self.cat.frame.midX  {
                    node.isHidden = true
                } else {
                    node.isHidden = false
                }
            }
        }
        
        
        //remove first or last element of the background if is out of screen and add it to the end or front (depends on cat's direction)
        if self.moveRight {
            if let first = backgrounds.first {
                if first.position.x + first.frame.width < 0 {
                    if let last = self.backgrounds.last {
                        self.backgrounds.removeFirst()
                        first.position.x = last.position.x + last.frame.width
                        self.backgrounds.append(first)
                    }
                }
            }
        } else {
            if let last = backgrounds.last {
                if last.position.x - last.frame.width > self.frame.width {
                    if let first = self.backgrounds.first {
                        self.backgrounds.removeLast()
                        last.position.x = first.position.x - last.frame.width
                        self.backgrounds.insert(last, at: 0)
                    }
                }
            }
        }
    }
}

extension MyScene {
    
    //create the cat
    func createCat() -> SKSpriteNode {
        let frames = SKTextureAtlas(named: "nyanrun").textureNames.map {SKTexture(imageNamed: $0)}
        
        let catNode = SKSpriteNode(texture: frames.first)
        catNode.size = CGSize(width: 50, height: 30)
        catNode.position = CGPoint(x: -30, y: 15)
        catNode.zPosition = 3
        catNode.name = "cat"
        
        catNode.run(SKAction.repeatForever(
            SKAction.animate(with: frames, timePerFrame: 0.3, resize: false, restore: true)),
                    withKey: "cat-animation")
        
        
        let body = SKPhysicsBody(rectangleOf: catNode.size)
        body.isDynamic = true
        body.affectedByGravity = false
        body.allowsRotation = false
        body.velocity.dx = self.catVelocity
        body.friction = 0
        
        catNode.physicsBody = body
        catNode.physicsBody?.applyImpulse(CGVector(dx: self.catVelocity, dy: 0))
        
        
        return catNode
    }
    
    //create the rainbows
    func createRainbows() {
        var xStart:CGFloat = -8
        while xStart < self.size.width + 10 {
            let rb = SKSpriteNode(imageNamed: "nyan-rainbow")
            rb.position = CGPoint(x:xStart,y:15)
            rb.zPosition = 2
            rb.name = "rainbow"
            self.addChild(rb)
            xStart += rb.frame.width
            
        }
    }
    
    //create the background
    func createBackground() {
        var xStart:CGFloat = -8
        while xStart < self.size.width + 400 {
            let rb = SKSpriteNode(imageNamed: "nyan-stars")
            rb.position = CGPoint(x:xStart,y:15)
            rb.zPosition = 1
            rb.name = "stars"
            self.addChild(rb)
            self.backgrounds.append(rb)
            xStart += rb.frame.width
            
        }
        //animate the bacground
        backgrounds.forEach { (node) in
            node.run(SKAction.repeatForever(SKAction.moveBy(x: (-1) * self.catVelocity, y: 0, duration: 1)), withKey: "stars-animation")
        }
    }
}

extension MyScene {
    
    func pauseAction()  {
        self.isPaused = !self.isPaused
    }
    
    func swipeAction()  {
        self.moveRight = !self.moveRight
        
        //change cat's orientation
        self.enumerateChildNodes(withName: "cat") {
            (node, stop) in
            if node.xScale > 0 {
                node.xScale = -1
            } else {
                node.xScale = 1
            }
        }
        
        //remobe the background animation
        self.removeAction(forKey: "star-animation")
        
        //add the background animation on the oposit direction
        backgrounds.forEach { (node) in
            node.run(SKAction.repeatForever(SKAction.moveBy(x: (-1) * self.catVelocity, y: 0, duration: 1)), withKey: "stars-animation")
        }
        
        //wakeup from pause
        if self.isPaused {
            pauseAction()
        }
        
    }
    
}
