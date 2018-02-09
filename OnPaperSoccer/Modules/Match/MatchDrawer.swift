import Foundation
import SpriteKit

protocol MatchDrawer {
    var view: UIView { get }

    func drawMatch()
}

private struct Position {
    let x: Int
    let y: Int
}

final class DefaultMatchDrawer: MatchDrawer {
    var view: UIView {
        return matchView
    }
    private let rows: Int
    private let columns: Int

    private let matchView = SKView()
    private let scene = SKScene()
    private var nodes = [[SKNode]]()

    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
    }

    func drawMatch() {
        setupScene()
        setupNodes()
    }

    // MARK: Helpers

    private func setupScene() {
        scene.size = matchView.bounds.size
        scene.backgroundColor = UIColor.darkGray
        scene.scaleMode = .aspectFit

        matchView.presentScene(scene)
    }

    private func setupNodes() {
        nodes = [[SKNode]]()

        for x in 0..<rows {
            var row = [SKNode]()
            nodes.append(row)
            for y in 0..<columns {
                let node = SKShapeNode(circleOfRadius: Constants.nodeRadius)
                row.append(node)
                node.position = positionInScene(row: x, column: y)
                let color = CGFloat(x + y)/CGFloat(rows + columns)
                node.fillColor = UIColor(white: color, alpha: 1.0)
                scene.addChild(node)
            }
        }
    }

    private func positionInScene(row: Int, column: Int) -> CGPoint {
        let horizontalSpacing = (scene.size.width - 2 * Constants.horizontalPadding) / CGFloat(columns - 1)
        let verticalSpacing = (scene.size.height - 2 * Constants.verticalPadding) / CGFloat(rows - 1)

        let x = Constants.horizontalPadding
                + CGFloat(column) * horizontalSpacing
                - Constants.nodeRadius
        let y = Constants.verticalPadding
                + CGFloat(row) * verticalSpacing
                - Constants.nodeRadius

        return CGPoint(x: x, y: y)
    }

    private struct Constants {
        static let horizontalPadding: CGFloat = 50.0
        static let verticalPadding: CGFloat = 50.0
        static let nodeRadius: CGFloat = 5.0
    }
}
