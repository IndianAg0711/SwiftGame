//
//  GameViewController.swift
//  SwiftGame
//
//  Created by Joseph Villafranca on 10/14/16.
//  Copyright (c) 2016 Grok Interactive, LLC. All rights reserved.
//

import UIKit
import SpriteKit
import SwiftPhoenixClient

class GameViewController: UIViewController {

  fileprivate let socket = Socket(domainAndPort: "localhost:4000", path: "socket", transport: "websocket")
  fileprivate var topic = "rooms:lobby"

  override func viewDidLoad() {
    super.viewDidLoad()
    let scene = GameScene(size: view.bounds.size)
    scene.gameSceneDelegate = self

    let skView = view as! SKView
    skView.showsFPS = true
    skView.showsNodeCount = true
    skView.ignoresSiblingOrder = true
    scene.scaleMode = .resizeFill
    skView.presentScene(scene)

    socket.join(topic: topic, message: Message(subject: "status", body: "joining")) { channel in
      let channel = channel as? Channel

      channel?.on(event: "join") { message in
        print(message)
      }
    }
  }

  override var prefersStatusBarHidden : Bool {
    return true
  }
}

extension GameViewController: GameSceneDelegate {
  func playerMoved() {
    print("Send Data to Server")
  }
}
