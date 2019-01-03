//
//  Constants.swift
//  Amoeba Wars
//
//  Created by Sean Kearney on 23/11/2018.
//  Copyright © 2018 Sean Kearney. All rights reserved.
//

import SpriteKit


import UIKit

struct ImageName {
    static let Background = "Background"
    static let HistolyticaLeft = "HistolyticaLeft"
    static let FowleriLeft = "FowleriLeft"
    static let ProteusLeft = "ProteusLeft"
    static let HistolyticaRight = "HistolyticaRight"
    static let FowleriRight = "FowleriRight"
    static let ProteusRight = "ProteusRight"
    static let Button = "Button"
    static let Coin = "Coin"
    static let BaseLeft = "Base_Left_Defence"
    static let BaseRight = "Base_Right_Defence"
    static let Base_Left_Attack = "Base_Left_Attack.png"
    static let Base_Right_Attack = "Base_Right_Attack.png"
}

struct Layer {
    static let Background: CGFloat = 0
    static let Button: CGFloat = 1
    static let HUD: CGFloat = 3
    static let Amoeba: CGFloat = 2
}

struct PhysicsCategory {
}

struct GameConfig {
    static let HistolyticaCost = 10
    static let FowleriCost = 25
    static let ProteusCost = 50
}
