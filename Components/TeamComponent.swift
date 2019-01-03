//
//  TeamComponent.swift
//  Amoeba Wars
//
//  Created by Sean Kearney on 03/01/2019.
//  Copyright © 2019 Sean Kearney. All rights reserved.
//

import SpriteKit
import GameplayKit

// 1
enum Team: String {
    case teamLeft = "Left"
    case teamRight = "Right"
    
    static let allValues = [teamLeft, teamRight]
    
    func oppositeTeam() -> Team {
        switch self {
        case .teamLeft:
            return .teamRight
        case .teamRight:
            return .teamLeft
        }
    }
}

// 2
class TeamComponent: GKComponent {
    let team: Team
    
    init(team: Team) {
        self.team = team
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
