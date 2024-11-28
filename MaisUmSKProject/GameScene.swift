//
//  GameScene.swift
//  MaisUmSKProject
//
//  Created by Francisco Miranda Soares on 27/11/24.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

    private var moveableNode: SKNode?
    private var ballNode: SKNode?

    private var scoreNode: SKLabelNode?
    private var goalP1Node: SKNode?
    private var goalP2Node: SKNode?
    private var scoreP1: Int = 0 { didSet { restartBall() } }
    private var scoreP2: Int = 0 { didSet { restartBall() } }

    override func didMove(to view: SKView) {

        self.physicsWorld.contactDelegate = self
        self.scoreNode = self.childNode(withName: "score") as? SKLabelNode
        self.goalP1Node = self.childNode(withName: "goalP1")
        self.goalP2Node = self.childNode(withName: "goalP2")

        guard let ballNode = self.childNode(withName: "ball") else { return }

        self.ballNode = ballNode
        restartBall()

        // configuring the scene's surrounding physics body
        let worldBody: SKPhysicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        worldBody.mass = 100
        worldBody.restitution = 1.0
        worldBody.friction = 0.0
        worldBody.linearDamping = 0.0
        worldBody.angularDamping = 0.0
        self.physicsBody = worldBody
    }

    // MARK: Ball functions

    fileprivate func kickOff() {
        let direction = Bool.random() ? 1.0 : -1.0
        let kick = 20.0 * direction
        self.ballNode?.run(.applyImpulse(CGVector(dx: kick, dy: 0.0), duration: 0.1))
    }

    func restartBall() {
        ballNode?.run(.move(to: .zero, duration: 0))

        kickOff()
    }

    // MARK: Touch functions

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let point = touch.location(in: self)
            let nodes = self.nodes(at: point)

            for node in nodes {
                if node == self {
                    print("There's self")
                } else {
                    if ![ballNode, goalP1Node, goalP2Node].contains(node) {
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
        scoreNode?.text = "\(scoreP1) x \(scoreP2)"
    }
}

// -MARK: Contact Delegate

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
//        print("Contact started between \(contact.bodyA) and \(contact.bodyB)")
        let bodies = [contact.bodyA, contact.bodyB]
        let nodes = bodies.map { $0.node }
        if nodes.contains([goalP1Node, ballNode]) {
            scoreP2 += 1
        } else if nodes.contains([goalP2Node, ballNode]) {
            scoreP1 += 1
        }

        for body in bodies {
            if body.restitution != 0 {
                print("body of \(body.node?.name ?? "unknown")'s restitution is \(body.restitution)")
            }
        }
    }

    func didEnd(_ contact: SKPhysicsContact) {
//        print("Contact ended between \(contact.bodyA) and \(contact.bodyB)")
    }
}
