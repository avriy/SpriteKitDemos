import Cocoa
import SpriteKit
import PlaygroundSupport

extension CGPath {
    static var dummyPath: CGPath {
        let path = CGMutablePath()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: 100, y: 100))
        path.addCurve(to: CGPoint(x: 200, y: 200), control1: CGPoint(x: 250, y: 100), control2: CGPoint(x: 170, y: 120))
        path.addCurve(to: CGPoint(x: 300, y: 300), control1: CGPoint(x: 250, y: 220), control2: CGPoint(x: 270, y: 120))
        return path
    }
}

class PathHolderScene: SKScene {
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        backgroundColor = .gray
        let shape = SKShapeNode(circleOfRadius: 10)
        shape.strokeColor = .clear
        
        addChild(shape)
        
        let block: (Void) -> Void = { [weak self, weak shape] in
            
            guard let strongSelf = self, let shape = shape, shape.parent != nil else { return }
            
            let footNode = SKShapeNode(circleOfRadius: 2)
            footNode.fillColor = .yellow
            footNode.strokeColor = .yellow
            footNode.position = shape.position
            strongSelf.addChild(footNode)
        }
        
        let followPathAndRemoveAction: SKAction = .sequence([.follow(CGPath.dummyPath, duration: 3), .removeFromParent()])
        let addFootNodeAction: SKAction = .sequence([.wait(forDuration: 0.1), .run(block)])
        
        let action: SKAction = .group([followPathAndRemoveAction, .repeatForever(addFootNodeAction)])
        
        shape.run(action)        
    }
}

let frame = CGRect(origin: .zero, size: CGSize(width: 640, height: 480))
let holderView = SKView(frame: frame)
let scene = PathHolderScene(size: frame.size)
holderView.presentScene(scene)

PlaygroundPage.current.liveView = holderView



