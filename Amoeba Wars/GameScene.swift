//
//  GameScene.swift
//  Amoeba Wars
//
//  Created by Sean Kearney on 23/11/2018.
//  Copyright © 2018 Sean Kearney. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let margin = CGFloat(175)
    
    var histolyticaButton: ButtonNode!
    var fowleriButton: ButtonNode!
    var proteusButton: ButtonNode!
    
    let coinLeftLabel = SKLabelNode(fontNamed: "Courier-Bold")
    let coinRightLabel = SKLabelNode(fontNamed: "Courier-Bold")
    let gameovertext = SKLabelNode(fontNamed: "Courier-Bold")
    
    var lastUpdateTimeInterval: TimeInterval = 0
    
    var gameOver = false
    
    var entityManager: EntityManager!
    var p2: EnemyAI?
    
    override func didMove(to view: SKView) {
        // Create entity manager
        entityManager = EntityManager(scene: self)
        p2 = EnemyAI(entityManager: entityManager)
        // Start background music
        let bgMusic = SKAudioNode(fileNamed: SoundFile.BackgroundMusic)
        bgMusic.autoplayLooped = true
        addChild(bgMusic)
        
        // Add background
        var background: SKSpriteNode!
        background = SKSpriteNode(imageNamed: ImageName.Background)
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.size = self.size
        background.zPosition = Layer.Background
        addChild(background)
        
        // Add histolytica button
        histolyticaButton = ButtonNode(iconName: ImageName.HistolyticaLeft, text: String(GameConfig.HistolyticaCost), onButtonPress: histolyticaPressed)
        histolyticaButton.zPosition = Layer.HUD
        histolyticaButton.position = CGPoint(x: size.width * 0.25, y: margin + histolyticaButton.size.height / 2)
        addChild(histolyticaButton)
        
        // Add fowleri button
        fowleriButton = ButtonNode(iconName: ImageName.FowleriLeft, text: String(GameConfig.FowleriCost), onButtonPress: fowleriPressed)
        fowleriButton.position = CGPoint(x: size.width * 0.5, y: margin + fowleriButton.size.height / 2)
        fowleriButton.zPosition = Layer.HUD
        addChild(fowleriButton)
        
        // Add proteus button
        proteusButton = ButtonNode(iconName: ImageName.ProteusLeft, text: String(GameConfig.ProteusCost), onButtonPress: proteusPressed)
        proteusButton.position = CGPoint(x: size.width * 0.75, y: margin + proteusButton.size.height / 2)
        proteusButton.zPosition = Layer.HUD
        addChild(proteusButton)
        
        // Add coin left indicator
        let coinLeft = SKSpriteNode(imageNamed: ImageName.Coin)
        
        coinLeft.position = CGPoint(x: margin + coinLeft.size.width/2,
                                    y: size.height - margin - coinLeft.size.height/2)
        coinLeft.zPosition = Layer.HUD
        addChild(coinLeft)
        coinLeftLabel.fontSize = 50
        coinLeftLabel.fontColor = SKColor.black
        coinLeftLabel.position = CGPoint(x: coinLeft.position.x + coinLeft.size.width + margin/4, y: coinLeft.position.y)
        coinLeftLabel.zPosition = Layer.HUD
        coinLeftLabel.horizontalAlignmentMode = .left
        coinLeftLabel.verticalAlignmentMode = .center
        coinLeftLabel.text = "0"
        self.addChild(coinLeftLabel)
        
        // Add coin right indicator
        let coinRight = SKSpriteNode(imageNamed: ImageName.Coin)
        
        coinRight.position = CGPoint(x: self.size.width - (margin + coinRight.size.width/2),
                                    y: size.height - margin - coinRight.size.height/2)
        coinRight.zPosition = Layer.HUD
        addChild(coinRight)
        coinRightLabel.fontSize = 50
        coinRightLabel.fontColor = SKColor.black
        coinRightLabel.position = CGPoint(x: coinRight.position.x - coinRight.size.width - margin/4, y: coinRight.position.y)
        coinRightLabel.zPosition = Layer.HUD
        coinRightLabel.horizontalAlignmentMode = .left
        coinRightLabel.verticalAlignmentMode = .center
        coinRightLabel.text = "0"
        self.addChild(coinRightLabel)
        
        // Add base left
        let baseLeft = Base(imageName: ImageName.Base_Left_Attack, team: .teamLeft, entityManager: entityManager)
        if let spriteComponent = baseLeft.component(ofType: SpriteComponent.self) {
            spriteComponent.node.position = CGPoint(x: spriteComponent.node.size.width/2, y: size.height/2)
        }
        entityManager.add(baseLeft)
        
        // Add base right
        let baseRight = Base(imageName: ImageName.Base_Right_Attack, team: .teamRight, entityManager: entityManager)
        if let spriteComponent = baseRight.component(ofType: SpriteComponent.self) {
            spriteComponent.node.position = CGPoint(x: size.width - spriteComponent.node.size.width/2, y: size.height/2)
        }
        entityManager.add(baseRight)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        print("\(touchLocation)")
        
        
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        let deltaTime = currentTime - lastUpdateTimeInterval
        lastUpdateTimeInterval = currentTime
        
        entityManager.update(deltaTime)
        
        // update player left coins
        if let playerLeft = entityManager.base(for: .teamLeft),
            let playerLeftBase = playerLeft.component(ofType: BaseComponent.self) {
            coinLeftLabel.text = "\(playerLeftBase.coins)"
        }
        
        // update player right coins
        if let playerRight = entityManager.base(for: .teamRight),
            let playerRightBase = playerRight.component(ofType: BaseComponent.self) {
            coinRightLabel.text = "\(playerRightBase.coins)"
            p2?.Play(coins: playerRightBase.coins)
        }
        
        //check if dead
        if let leftHealth = entityManager.base(for: .teamLeft)?.component(ofType: HealthComponent.self) {
            if leftHealth.health <= 0 {
                print("Right Player Wins!")
                gameovertext.fontSize = 50
                gameovertext.fontColor = SKColor.black
                gameovertext.position = CGPoint(x: size.width/2, y:size.height/2)
                gameovertext.zPosition = Layer.HUD
                gameovertext.text = "Right Player Wins!!"
                self.addChild(gameovertext)
                gameOver = true
                let newScene = GameScene(size: self.size)
                newScene.scaleMode = self.scaleMode
                let animation = SKTransition.fade(withDuration: 1.0)
                self.view?.presentScene(newScene, transition: animation)
            }
        }
        if let rightHealth = entityManager.base(for: .teamRight)?.component(ofType: HealthComponent.self) {
            if rightHealth.health <= 0 {
                print("Left Player Wins!")
                gameovertext.fontSize = 50
                gameovertext.fontColor = SKColor.black
                gameovertext.position = CGPoint(x: size.width/2, y:size.height/2)
                gameovertext.zPosition = Layer.HUD
                gameovertext.text = "Left Player Wins!!"
                self.addChild(gameovertext)
                gameOver = true
                let newScene = GameScene(size: self.size)
                newScene.scaleMode = self.scaleMode
                let animation = SKTransition.fade(withDuration: 1.0)
                self.view?.presentScene(newScene, transition: animation)
            }
        }
    }
    
    //MARK: - Button methods
    func histolyticaPressed() {
        print("Histolytica pressed!")
        entityManager.spawnHistolytica(team: .teamLeft)
    }
    func fowleriPressed() {
        print("fowleri pressed!")
        entityManager.spawnFowleri(team: .teamLeft)
    }
    func proteusPressed(){
        print("proteus pressed!")
        entityManager.spawnProteus(team: .teamLeft)
    }
}

