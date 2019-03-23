//: Simulating Self-Driving Cars

import PlaygroundSupport
import SpriteKit

let scene = Scene()
let sceneView = SKView(frame: CGRect(origin: .zero, size: CGSize(width: 700, height: 540)))
sceneView.showsDrawCount = true
sceneView.showsFPS = true
sceneView.showsNodeCount = true
sceneView.ignoresSiblingOrder = true
sceneView.preferredFramesPerSecond = UIScreen.main.maximumFramesPerSecond
sceneView.presentScene(scene)

PlaygroundPage.current.liveView = sceneView
