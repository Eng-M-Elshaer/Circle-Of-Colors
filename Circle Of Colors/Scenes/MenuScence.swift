//
//  MenuScence.swift
//  Circle Of Colors
//
//  Created by Mohamed Elshaer on 8/27/19.
//  Copyright © 2019 Mohamed Elshaer. All rights reserved.
//

import SpriteKit

class MenuScence: SKScene {
    
    override func didMove(to view: SKView) {
        backgroundColor = UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 1.0)
        addLogo()
        addLabels()
    }
    
    func addLogo(){
        let logo = SKSpriteNode(imageNamed: "logo")
        logo.size = CGSize(width: frame.size.width/4, height: frame.size.width/4)
        logo.position = CGPoint(x: frame.midX, y: frame.midY + frame.size.height/4)
        addChild(logo)
    }
    
    func addLabels(){
        
        let playLabel = SKLabelNode(text: "Tap to Play")
        playLabel.fontName = "AvenirNext-Bold"
        playLabel.fontSize = 40.0
        playLabel.fontColor = UIColor.white
        playLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(playLabel)
        animte(lable: playLabel)
        let highSocre = SKLabelNode(text: "High Score:" + "\(UserDefaults.standard.integer(forKey: "HighScore"))")
        highSocre.fontName = "AvenirNext-Bold"
        highSocre.fontSize = 30.0
        highSocre.fontColor = UIColor.white
        highSocre.position = CGPoint(x: frame.midX, y: frame.midY - highSocre.frame.size.height * 4)
        addChild(highSocre)
        let recentSocre = SKLabelNode(text: "Recent Score:" + "\(UserDefaults.standard.integer(forKey: "RecentScore"))")
        recentSocre.fontName = "AvenirNext-Bold"
        recentSocre.fontSize = 30.0
        recentSocre.fontColor = UIColor.white
        recentSocre.position = CGPoint(x: frame.midX, y: highSocre.position.y - recentSocre.frame.size.height * 2)
        addChild(recentSocre)
        
    }
    
    func animte(lable:SKLabelNode){
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        let fadeIn = SKAction.fadeIn(withDuration: 0.5)
//        let scaleUp =  SKAction.scale(to: 1.1, duration: 0.5)
//        let scaleDown =  SKAction.scale(to: 1.0, duration: 0.5)
        let sequence = SKAction.sequence([fadeOut,fadeIn])
        lable.run(SKAction.repeatForever(sequence))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let gameScence = GameScene(size: view!.bounds.size)
        view!.presentScene(gameScence)
    }
}
