//
//  GameScene.swift
//  Pong
//
//  Created by Mehul Gupta on 7/22/17.
//  Copyright © 2017 Mehul Gupta. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var ball = SKSpriteNode()
    var paddleEnemy = SKSpriteNode()
    var paddleMain = SKSpriteNode()
    
    var mainLabel = SKLabelNode()
    var enemyLabel = SKLabelNode()
    
    var score = [Int]()
    var ballSpeed = 15
        
    override func didMove(to view: SKView) {
        
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        mainLabel = self.childNode(withName: "mainLabel") as! SKLabelNode
        enemyLabel = self.childNode(withName: "enemyLabel") as! SKLabelNode
        
        paddleMain = self.childNode(withName: "paddleMain") as! SKSpriteNode
        paddleMain.position.y = (-self.frame.height / 2) + 50
    
        paddleEnemy = self.childNode(withName: "paddleEnemy") as! SKSpriteNode
        paddleEnemy.position.y = (self.frame.height / 2) - 50
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        self.physicsBody = border
        
        startGame()
    }
    
    func startGame() {
        score = [0,0] // [paddleMain score, paddleEnemy score]
        
        mainLabel.text = "\(score[0])"
        enemyLabel.text = "\(score[1])"
        
        // Start the game
        applyImpulse(direction: -1, speed: ballSpeed)
    }
    
    func applyImpulse(direction: Int, speed: Int) {
        // ball.physicsBody?.applyImpulse(CGVector(dx: -10, dy: -10))
        ball.physicsBody?.applyImpulse(CGVector(dx: speed * direction, dy: speed * direction))
    }
    
    func changeBallSpeed(byPoints: Int) -> Int {
        
        // underflow condition to make ballSpeed atleast 10
        ballSpeed = ballSpeed == 10 ? 10 : ballSpeed + byPoints
        return ballSpeed
    }

    func addScore(playerWhoWon: SKSpriteNode) {
        
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)

        
        if playerWhoWon == paddleMain {
            score[0] += 1
            
            // Increase speed of the ball when I score a point
            applyImpulse(direction: 1, speed: changeBallSpeed(byPoints: 1))
            
        } else if playerWhoWon == paddleEnemy {
            score[1] += 1
            
            // Decrease speed of the basll when enemy scores a point
            applyImpulse(direction: -1, speed: changeBallSpeed(byPoints: -1))
        }
        
        mainLabel.text = "\(score[0])"
        enemyLabel.text = "\(score[1])"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            if currentGameType == .player2{
                
                if location.y < 0 {
                    paddleMain.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
                
                if location.y > 0 {
                    paddleEnemy.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
            } else {
                paddleMain.run(SKAction.moveTo(x: location.x, duration: 0.2))
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            if currentGameType == .player2{
                
                if location.y < 0 {
                    paddleMain.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
                
                if location.y > 0 {
                    paddleEnemy.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
            } else {
                paddleMain.run(SKAction.moveTo(x: location.x, duration: 0.2))
            }
        }
    }

    override func update(_ currentTime: TimeInterval) {

        // Variable to set bot's reaction speed based on difficulty level
        var enemyDuration = 0.0
        
        
        switch currentGameType {
        case .easy:
            enemyDuration = 2.0
            paddleEnemy.run(SKAction.moveTo(x: ball.position.x, duration: enemyDuration))
            break
            
        case .medium:
            enemyDuration = 1.4
            paddleEnemy.run(SKAction.moveTo(x: ball.position.x, duration: enemyDuration))
            break
            
        case .hard:
            enemyDuration = 0.9
            paddleEnemy.run(SKAction.moveTo(x: ball.position.x, duration: enemyDuration))
            break
            
        case .player2:
            break
        }
        
        if ball.position.y < paddleMain.position.y - 30 {
            addScore(playerWhoWon: paddleEnemy)

        } else if ball.position.y > paddleEnemy.position.y + 30 {
            addScore(playerWhoWon: paddleMain)
            
        }
    }
}
