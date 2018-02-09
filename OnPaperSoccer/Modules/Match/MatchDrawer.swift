import Foundation
import SpriteKit

protocol MatchDrawer {
    var view: UIView { get }

    func draw()
    func start()
}

final class DefaultMatchDrawer: MatchDrawer {
    var view: UIView {
        return matchView
    }

    private let matchView = SKView()
    private let scene = SKScene()

    func start() {
        scene.size = matchView.bounds.size
        scene.backgroundColor = UIColor.darkGray
        scene.scaleMode = .aspectFit

        matchView.presentScene(scene)
    }

    func draw() {
        let node = createNode()
        scene.addChild(node)
    }

    private func createNode() -> SKShapeNode {
        let node = SKShapeNode(circleOfRadius: 5.0)
        node.fillColor = UIColor.red
        node.position = CGPoint(x: scene.size.width/2, y: scene.size.height/2)
        node.zPosition = 2

        return node
    }
}
