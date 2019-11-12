//
//  FightController.swift
//  Korgath
//
//  Created by XAVIER CARLOS on 12/11/2019.
//  Copyright © 2019 Sebastien XAVIER CARLOS. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import GameplayKit

class FightController: UIViewController {

    override func viewDidLoad() {
    super.viewDidLoad()
        pvActualHero(damage: 0)
        pvActualEnnemi(damage: 0)
    }
    
    
    //    début de mon code spécifique
        
        var pvMax = ["pvMaxHero": 100, "pvMaxEnnemi": 100]
         var pvActual = ["pvHero": 100, "pvEnnemi": 100]
         
         var damage = 0
             
         @IBOutlet weak var heroLife: UILabel!
         @IBOutlet weak var ennemiLife: UILabel!

         
         func pvActualHero(damage: Int) -> Int {
            pvActual["pvHero"]! -= damage

            let quoteLifeH = "\(String(describing: pvActual["pvHero"]!)) / \(String(describing: pvMax["pvMaxHero"]!))"
             
             heroLife.text = quoteLifeH
             
             return pvActual["pvHero"]!
             
         }
         
        func pvActualEnnemi(damage: Int) -> Int { pvActual["pvEnnemi"]! -= damage
         
         let quoteLifeE = "\(String(describing: pvActual["pvEnnemi"]!)) / \(String(describing: pvMax["pvMaxEnnemi"]!))"
         
         ennemiLife.text = quoteLifeE
         
            return pvActual["pvEnnemi"]!
         
         }
        
    
    @IBAction func attack() {
    }
    
    @IBAction func defend() {
    }
    
    @IBAction func trick() {
    }
    
        
}
