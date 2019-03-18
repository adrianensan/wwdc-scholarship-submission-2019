//: Simulating Self-Driving Cars

import PlaygroundSupport
import SpriteKit

let scene = Scene()
let sceneView = SKView(frame: CGRect(origin: .zero, size: CGSize(width: 700, height: 700)))
sceneView.showsDrawCount = true
sceneView.showsFPS = true
sceneView.presentScene(scene)

PlaygroundPage.current.liveView = sceneView
