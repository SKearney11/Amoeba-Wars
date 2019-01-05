//
//  HealthComponent.swift
//  Amoeba Wars
//
//  Created by Sean Kearney on 05/01/2019.
//  Copyright © 2019 Sean Kearney. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class HealthComponent: GKComponent, GKAgentDelegate{
    let entityManager: EntityManager
    var health: Int
    var damage: Int
    var team : Team
    
    init(health: Int, damage: Int, team:Team, entityManager: EntityManager) {
        self.entityManager = entityManager
        self.health = health
        self.damage = damage
        self.team = team
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        if health <= 0 {
            entityManager.remove(entity!)
        }
        
        let position = entity?.component(ofType: SpriteComponent.self)?.node.position
        
        entityManager.entities(for: team.oppositeTeam()).forEach{ enemy in
            let enemyPosition = enemy.component(ofType: SpriteComponent.self)?.node.position
            if (position?.distance(point: enemyPosition!))! < CGFloat(100.0){
                enemy.component(ofType: HealthComponent.self)?.takeDamage(damage: damage)
            }
        }
    }
    
    func takeDamage(damage: Int){
        health -= damage
    }
}
