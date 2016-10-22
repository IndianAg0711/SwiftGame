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

  private let socket = Phoenix.Socket(domainAndPort: "localhost:4000", path: "socket", transport: "websocket")
  private var topic = "rooms:lobby"

  override func viewDidLoad() {
    super.viewDidLoad()
    let scene = GameScene(size: view.bounds.size)
    scene.gameSceneDelegate = self

    let skView = view as! SKView
    skView.showsFPS = true
    skView.showsNodeCount = true
    skView.ignoresSiblingOrder = true
    scene.scaleMode = .ResizeFill
    skView.presentScene(scene)

    socket.join(topic: topic, message: Phoenix.Message(subject: "status", body: "joining")) { channel in
      let channel = channel as? Phoenix.Channel

      channel?.on("join") { message in
        print(message)
      }
    }
  }

  override func prefersStatusBarHidden() -> Bool {
    return true
  }
}

extension GameViewController: GameSceneDelegate {
  func playerMoved() {
    print("Send Data to Server")
  }
}