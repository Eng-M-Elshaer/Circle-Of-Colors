//
//  Settings.swift
//  Circle Of Colors
//
//  Created by Mohamed Elshaer on 8/27/19.
//  Copyright © 2019 Mohamed Elshaer. All rights reserved.
//

import SpriteKit

//MARK:- PhysicsCategories
enum PhysicsCategories {
    static let none:UInt32 = 0
    static let ballCategory:UInt32 = 0x1        // 01
    static let switchCategory:UInt32 = 0x1 << 1 // 10
}

//MARK:- ZPositions
enum ZPositions {
    static let label:CGFloat = 0
    static let ball:CGFloat = 1
    static let colorSwitch:CGFloat = 2
}

//MARK:- PlayColors
enum PlayColors {
    static let colors = [
        UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1.0),
        UIColor(red: 241/255, green: 196/255, blue: 12/255, alpha: 1.0),
        UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1.0),
        UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1.0)
    ]
}

//MARK:- SwitchSate
enum SwitchSate: Int {
    case red, yellow, green, blue
}
