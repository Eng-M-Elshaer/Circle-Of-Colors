//
//  GameVC.swift
//  Circle Of Colors
//
//  Created by Mohamed Elshaer on 8/27/19.
//  Copyright © 2019 Mohamed Elshaer. All rights reserved.
//

import UIKit
import SpriteKit

class GameVC: UIViewController {

    //MARK:- Lifecycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTheGame()
    }
}

extension GameVC {
    private func setupTheGame(){
        if let view = self.view as! SKView? {
            let scene = MenuScence(size: view.bounds.size)
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
                
            // Present the scene
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
}
