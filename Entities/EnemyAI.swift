//
//  EnemyAI.swift
//  Amoeba Wars
//
//  Created by Sean Kearney on 05/01/2019.
//  Copyright © 2019 Sean Kearney. All rights reserved.
//

import Foundation

class EnemyAI{
    var lastAmoeba: Int
    var entityManager: EntityManager
    
    init(entityManager: EntityManager){
        self.entityManager = entityManager
        lastAmoeba = 1
    }
    
    func Play(coins: Int){
        //add delay between attacks to allow enemy to gather enough points to spawn different ameoba 
        let attackNumber = Int.random(in: 0 ... 100)
        if attackNumber >= 90{
            attack(coins: coins)
        }
    }
    
    func attack(coins: Int){
        let number = Int.random(in: 0 ... 100)
        
        switch lastAmoeba {
        case 1:
            if number > 50 && coins >= GameConfig.HistolyticaCost {
                entityManager.spawnHistolytica(team: .teamRight)
                lastAmoeba = 1
            } else if number > 30 && coins >= GameConfig.FowleriCost {
                entityManager.spawnFowleri(team: .teamRight)
                lastAmoeba = 2
            } else if coins >= GameConfig.ProteusCost {
                entityManager.spawnProteus(team: .teamRight)
                lastAmoeba = 3
            }
            break
        case 2:
            if number > 60 && coins >= GameConfig.HistolyticaCost {
                entityManager.spawnHistolytica(team: .teamRight)
                lastAmoeba = 1
            } else if number > 20 && coins >= GameConfig.FowleriCost {
                entityManager.spawnFowleri(team: .teamRight)
                lastAmoeba = 2
            } else if coins >= GameConfig.ProteusCost {
                entityManager.spawnProteus(team: .teamRight)
                lastAmoeba = 3
            }
            break
        case 3:
            if number > 70 && coins >= GameConfig.HistolyticaCost {
                entityManager.spawnHistolytica(team: .teamRight)
                lastAmoeba = 1
            } else if number > 20 && coins >= GameConfig.FowleriCost {
                entityManager.spawnFowleri(team: .teamRight)
                lastAmoeba = 2
            } else if coins >= GameConfig.ProteusCost {
                entityManager.spawnProteus(team: .teamRight)
                lastAmoeba = 3
            }
            break
        default:
            if coins >= GameConfig.HistolyticaCost{
                entityManager.spawnHistolytica(team: .teamRight)
                lastAmoeba = 1
            }
        }
    }
}
