//
//  GameViewController.swift
//  Korgath
//
//  Created by XAVIER CARLOS on 12/11/2019.
//  Copyright © 2019 Sebastien XAVIER CARLOS. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
//        // including entities and graphs.
//        if let scene = GKScene(fileNamed: "GameScene") {
//
//            // Get the SKScene from the loaded GKScene
//            if let sceneNode = scene.rootNode as! GameScene? {
//
//                // Copy gameplay related content over to the scene
//                sceneNode.entities = scene.entities
//                sceneNode.graphs = scene.graphs
//
//                // Set the scale mode to scale to fit the window
//                sceneNode.scaleMode = .aspectFill
//
//                // Present the scene
//                if let view = self.view as! SKView? {
//                    view.presentScene(sceneNode)
//
//                    view.ignoresSiblingOrder = true
//
//                    view.showsFPS = true
//                    view.showsNodeCount = true
//                }
//            }
//        }
        
        pvActualHero(damage: 0)
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
//    début de mon code spécifique
    
    var pvMax = ["pvMaxHero": 100, "pvMaxEnnemi": 100]
     var pvActual = ["pvHero": 100, "pvEnnemi": 100]
     
     var damage = 0
         
     @IBOutlet weak var heroLife: UILabel!
     @IBOutlet weak var ennemiLife: UILabel!

     
     func pvActualHero(damage: Int) -> Int {
        pvActual["pvHero"]! -= damage

//         let quoteLifeH = "\(String(describing: pvActual["pvHero"]!)) / \(String(describing: pvMax["pvMaxHero"]!))"
         
         heroLife.text = "test"
         
         return pvActual["pvHero"]!
         
     }
     
    func pvActualEnnemi(damage: Int) -> Int { pvActual["pvEnnemi"]! -= damage
     
     let quoteLifeE = "\(String(describing: pvActual["pvEnnemi"])) / \(String(describing: pvMax["pvMaxEnnemi"]))"
     
     ennemiLife.text = quoteLifeE
     
        return pvActual["pvEnnemi"]!
     
     }
    
    
}
