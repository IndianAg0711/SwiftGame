//
//  GameScene.swift
//  SwiftGame
//
//  Created by Joseph Villafranca on 10/14/16.
//  Copyright (c) 2016 Grok Interactive, LLC. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
  var gameSceneDelegate: GameSceneDelegate?

  let player = SKSpriteNode(imageNamed: "player")

  override func didMove(to view: SKView) {
    // 2
    backgroundColor = SKColor.white
    // 3
    player.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
    // 4
    addChild(player)
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    for touch in touches {
      let point = touch.location(in: self)

      player.run(SKAction.move(to: point, duration: 1.0))

      gameSceneDelegate?.playerMoved()
    }
  }
}

protocol GameSceneDelegate {
  func playerMoved()
}
