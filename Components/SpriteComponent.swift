//
//  SpriteComponent.swift
//  Amoeba Wars
//
//  Created by Sean Kearney on 28/11/2018.
//  Copyright © 2018 Sean Kearney. All rights reserved.
//

// 1
import SpriteKit
import GameplayKit

// 2
class SpriteComponent: GKComponent {
    
    // 3
    let node: SKSpriteNode
    
    // 4
    init(texture: SKTexture) {
        node = SKSpriteNode(texture: texture, color: .white, size: texture.size())
        super.init()
    }
    
    // 5
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
