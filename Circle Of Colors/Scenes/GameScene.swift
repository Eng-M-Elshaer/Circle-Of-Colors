//
//  GameScene.swift
//  Circle Of Colors
//
//  Created by Mohamed Elshaer on 8/27/19.
//  Copyright © 2019 Mohamed Elshaer. All rights reserved.
//

import SpriteKit

enum PlayColors {
    static let colors = [
        UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1.0),
        UIColor(red: 241/255, green: 196/255, blue: 12/255, alpha: 1.0),
        UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1.0),
        UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1.0)
    ]
}

enum SwitchSate: Int {
    case red, yellow, green, blue
}

class GameScene: SKScene {
    
    var colorSwitch:SKSpriteNode!
    var switchSate = SwitchSate.red
    var currentColorIndex:Int?
    var score = 0
    let socreLable = SKLabelNode(text: "0")
    
    
    override func didMove(to view: SKView) {
        setupPhysics()
        layoutScence()
    }
    
    
    
    func setupPhysics(){
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -1.0)
        physicsWorld.contactDelegate = self
    }
    
    func layoutScence(){
        
        backgroundColor = UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 1.0)
        
        colorSwitch = SKSpriteNode(imageNamed: "ColorCircle")
        colorSwitch.size = CGSize(width: frame.size.width/3, height: frame.size.width/3)
        colorSwitch.position = CGPoint(x: frame.midX, y: frame.minY + colorSwitch.size.height)
        colorSwitch.zPosition = ZPositions.colorSwitch
        colorSwitch.physicsBody = SKPhysicsBody(circleOfRadius: colorSwitch.size.width/2)
        colorSwitch.physicsBody?.categoryBitMask = PhysicsCategories.switchCategory
        colorSwitch.physicsBody?.isDynamic = false
        addChild(colorSwitch)
        
        socreLable.fontName = "AvenirNext-Bold"
        socreLable.fontSize = 60.0
        socreLable.fontColor = UIColor.white
        socreLable.position = CGPoint(x: frame.midX, y: frame.midY)
        socreLable.zPosition = ZPositions.label
        addChild(socreLable)
        
        spawnBall()
    }
    
    func updateScore(){
        socreLable.text = "\(score)"
    }
    
    func spawnBall(){
        
        currentColorIndex = Int(arc4random_uniform(UInt32(4)))
        
        let ball = SKSpriteNode(texture: SKTexture(imageNamed: "ball"), color: PlayColors.colors[currentColorIndex!], size: CGSize(width: 30.0, height: 30.0))
        ball.colorBlendFactor = 1.0
        ball.name = "Ball"
        ball.position = CGPoint(x: frame.midX, y: frame.maxY)
        ball.zPosition = ZPositions.ball
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width/2)
        ball.physicsBody?.categoryBitMask = PhysicsCategories.ballCategory
        ball.physicsBody?.contactTestBitMask = PhysicsCategories.switchCategory
        ball.physicsBody?.collisionBitMask = PhysicsCategories.none
        
        addChild(ball)
        
    }
    
    func turnWheel(){
        
        if let newSate = SwitchSate(rawValue: switchSate.rawValue + 1 ) {
            switchSate = newSate
        } else {
            switchSate = .red
        }
        
        colorSwitch.run(SKAction.rotate(byAngle: .pi/2, duration: 0.25))
    }
    
    func gameOver(){
        
        UserDefaults.standard.set(score, forKey: "RecentScore")
        
        if score > UserDefaults.standard.integer(forKey: "HighScore") {
            UserDefaults.standard.set(score, forKey: "HighScore")
        }
        
        run(SKAction.playSoundFileNamed("over", waitForCompletion: false))

        let menuSence = MenuScence(size: view!.bounds.size)
        view!.presentScene(menuSence)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        turnWheel()
    }
    
}

extension GameScene:SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if contactMask == PhysicsCategories.ballCategory | PhysicsCategories.switchCategory {
            
            if let ball = contact.bodyA.node?.name == "Ball" ? contact.bodyA.node as? SKSpriteNode : contact.bodyB.node as? SKSpriteNode {
                
                if currentColorIndex == switchSate.rawValue {
                    score+=1
                    run(SKAction.playSoundFileNamed("win", waitForCompletion: false))
                    updateScore()
                    ball.run(SKAction.fadeOut(withDuration: 0.25), completion: {
                        ball.removeFromParent()
                        self.spawnBall()
                    })
                } else {
                    gameOver()
                }
            }
        }
    }
}
