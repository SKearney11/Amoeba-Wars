//
//  Histolytica.swift
//  Amoeba Wars
//
//  Created by Sean Kearney on 03/01/2019.
//  Copyright © 2019 Sean Kearney. All rights reserved.
//

import SpriteKit
import GameplayKit

class Histolytica: GKEntity {
    
    init(team: Team, entityManager: EntityManager) {
        super.init()
        let imageName = team.rawValue=="Left" ? ImageName.HistolyticaLeft : ImageName.HistolyticaRight;
        let texture = SKTexture(imageNamed: imageName)
        let spriteComponent = SpriteComponent(texture: texture)
        addComponent(spriteComponent)
        addComponent(TeamComponent(team: team))
        
        addComponent(MoveComponent(maxSpeed: 150, maxAcceleration: 5, radius: Float(texture.size().width * 0.3), entityManager: entityManager))
        addComponent(HealthComponent(health: 10, damage: 5, team: team, entityManager: entityManager))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
