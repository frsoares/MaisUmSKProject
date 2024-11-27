//
//  GameScene.swift
//  MaisUmSKProject
//
//  Created by Francisco Miranda Soares on 27/11/24.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?

    private var moveableNode: SKNode?

    var ballNode: SKNode?

    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self

        guard let ballNode = self.childNode(withName: "ball") else { return }

        ballNode.physicsBody?.applyImpulse(CGVector(dx: 20.0, dy: 0.0))
        self.ballNode = ballNode

        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
    }

    // MARK: Touch functions

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for touch in touches {
            let point = touch.location(in: self)
            let nodes = self.nodes(at: point)

            for node in nodes {
                if node == self {
                    print("There's self")
                } else {
                    if node != ballNode {
                        moveableNode = node
                    }
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let moveableNode {
            var location: CGPoint? = nil

            for touch in touches {
                location = touch.location(in: self)
            }

            if let location {
                moveableNode.position.y = location.y
            }
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.moveableNode = nil
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("oops, touch cancelled!")

        self.moveableNode = nil
    }

    // MARK: update function

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

// -MARK: Contact Delegate

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        print("Contact started between \(contact.bodyA) and \(contact.bodyB)")
    }

    func didEnd(_ contact: SKPhysicsContact) {
        print("Contact ended between \(contact.bodyA) and \(contact.bodyB)")
    }
}
