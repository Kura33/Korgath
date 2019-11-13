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
import AVFoundation

class FightController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        appel du clacul pv à afficher au lancement
        pvActualHero(damage: 0)
        pvActualEnnemi(damage: 0)
    }
    
    
    //    début de mon code spécifique
    
    var pvMax = ["pvMaxHero": 100, "pvMaxEnnemi": 100]
    var pvActual = ["pvHero": 100, "pvEnnemi": 100]
    var player:AVAudioPlayer!
    
    @IBOutlet weak var heroLife: UILabel!
    @IBOutlet weak var ennemiLife: UILabel!
    @IBOutlet weak var combatLog: UILabel!
    
    func PlayAttackOrc(){
        guard let path = Bundle.main.path(forResource: "attackOrc", ofType: "wav")else{return}
        let soundURl = URL(fileURLWithPath: path)
        player = try? AVAudioPlayer(contentsOf: soundURl)
        player.prepareToPlay()
        player.play()
        //player.pause()
        //player.stop()
    }
    func PlayDefendOrc(){
        guard let path = Bundle.main.path(forResource: "defendOrc", ofType: "m4a")else{return}
        let soundURl = URL(fileURLWithPath: path)
        player = try? AVAudioPlayer(contentsOf: soundURl)
        player.prepareToPlay()
        player.play()
        //player.pause()
        //player.stop()
    }
    func PlayTrickOrc(){
        guard let path = Bundle.main.path(forResource: "trickOrc", ofType: "wav")else{return}
        let soundURl = URL(fileURLWithPath: path)
        player = try? AVAudioPlayer(contentsOf: soundURl)
        player.prepareToPlay()
        player.play()
        //player.pause()
        //player.stop()
    }
    func PlayAttackKnight(){
        guard let path = Bundle.main.path(forResource: "attackKnight", ofType: "m4a")else{return}
        let soundURl = URL(fileURLWithPath: path)
        player = try? AVAudioPlayer(contentsOf: soundURl)
        player.prepareToPlay()
        player.play()
        //player.pause()
        //player.stop()
    }
    func PlayDefendKnight(){
        guard let path = Bundle.main.path(forResource: "defendKnight", ofType: "m4a")else{return}
        let soundURl = URL(fileURLWithPath: path)
        player = try? AVAudioPlayer(contentsOf: soundURl)
        player.prepareToPlay()
        player.play()
        //player.pause()
        //player.stop()
    }
    func PlayTrickKnight(){
        guard let path = Bundle.main.path(forResource: "trickKnight", ofType: "m4a")else{return}
        let soundURl = URL(fileURLWithPath: path)
        player = try? AVAudioPlayer(contentsOf: soundURl)
        player.prepareToPlay()
        player.play()
        //player.pause()
        //player.stop()
    }
    func PlayDraw(){
        guard let path = Bundle.main.path(forResource: "attackSword", ofType: "wav")else{return}
        let soundURl = URL(fileURLWithPath: path)
        player = try? AVAudioPlayer(contentsOf: soundURl)
        player.prepareToPlay()
        player.play()
        //player.pause()
        //player.stop()
    }
    func pvActualHero(damage: Int) -> Int {
        pvActual["pvHero"]! -= damage
        if pvActual["pvHero"]! < 0 {
            pvActual["pvHero"] = 0
        }
        
        let quoteLifeH = "\(String(describing: pvActual["pvHero"]!)) / \(String(describing: pvMax["pvMaxHero"]!))"
        
        heroLife.text = quoteLifeH
        
        if pvActual["pvHero"]! == 0 {
        //            switch view
                 let storyboard = UIStoryboard(name: "Main", bundle: nil)
                 let controller = storyboard.instantiateViewController(withIdentifier: "GvcLoose")
                 self.present(controller, animated: true, completion: nil)

                }
        return pvActual["pvHero"]!
        
    }
    
    func pvActualEnnemi(damage: Int) -> Int {
        pvActual["pvEnnemi"]! -= damage
        if pvActual["pvEnnemi"]! < 0 {
            pvActual["pvEnnemi"] = 0
        }
        
        let quoteLifeE = "\(String(describing: pvActual["pvEnnemi"]!)) / \(String(describing: pvMax["pvMaxEnnemi"]!))"
        
        ennemiLife.text = quoteLifeE
        
        if pvActual["pvEnnemi"]! == 0 {
//            switch view
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let controller = storyboard.instantiateViewController(withIdentifier: "GvcWin")
         self.present(controller, animated: true, completion: nil)

        }
        return pvActual["pvEnnemi"]!
        
    }
    
    func fight(heroChoice:String) {
        let choice = ["attack", "defend", "trick"]
        //        random ennemi choice
        let ennemiChoice = choice[Int(arc4random_uniform(UInt32(choice.count)))]
        var heroDamage = 0
        var ennemiDamage = 0
        let dmgNormal = 10
        let dmgCrit = 15
        
        
        //        if else
        if (heroChoice == ennemiChoice) {
            print("equal")
            heroDamage += dmgNormal
            ennemiDamage += dmgNormal
            
            //            text combat logs
            combatLog.text = "Korgath \(heroChoice)! \nThe Knight \(ennemiChoice)! \nKorgath and The Knight incur a loss of \(dmgNormal) PV each!"
            PlayDraw()
            
        } else if (heroChoice == "attack" && ennemiChoice == "defend"){
            heroDamage += dmgCrit
            //            text combat log
            combatLog.text = "Korgath \(heroChoice)! \nThe Knight \(ennemiChoice)! \nKorgath incur a loss of \(dmgCrit) PV!"
            PlayDefendKnight()
            
        } else if (heroChoice == "attack" && ennemiChoice == "trick"){
            ennemiDamage += dmgCrit
            //    WINN e = damage +5
            combatLog.text = "Korgath \(heroChoice)! \nThe Knight \(ennemiChoice)! \nThe Knight incur a loss of \(dmgCrit) PV!"
            PlayAttackOrc()
            
        } else if (heroChoice == "defend" && ennemiChoice == "attack"){
            ennemiDamage += dmgCrit
            //    WINN e = damage +5
            combatLog.text = "Korgath \(heroChoice)! \nThe Knight \(ennemiChoice)! \nThe Knight incur a loss of \(dmgCrit) PV!"
            PlayDefendOrc()
            
        } else if (heroChoice == "defend" && ennemiChoice == "trick"){
            heroDamage += dmgCrit
            //    LOOSE h = damage +5
            combatLog.text = "Korgath \(heroChoice)! \nThe Knight \(ennemiChoice)! \nKorgath incur a loss of \(dmgCrit) PV!"
            PlayTrickKnight()
            
        } else if (heroChoice == "trick" && ennemiChoice == "attack"){
            heroDamage += dmgCrit
            //    LOOSE h = damage +5
            combatLog.text = "Korgath \(heroChoice)! \nThe Knight \(ennemiChoice)! \nKorgath incur a loss of \(dmgCrit) PV!"
            PlayAttackKnight()
            
        } else if (heroChoice == "trick" && ennemiChoice == "defend"){
            ennemiDamage += dmgCrit
            //    WINN e = damage +5
            combatLog.text = "Korgath \(heroChoice)! \nThe Knight \(ennemiChoice)! \nThe Knight incur a loss of \(dmgCrit) PV!"
            PlayTrickOrc()
            
        }
        
        //        appeler func pv1ActualH ou E
        
        pvActualHero(damage: heroDamage)
        pvActualEnnemi(damage: ennemiDamage)
        
    }
    
    
    
    
    @IBAction func attack() {
        fight(heroChoice: "attack")
        
        
    }
    
    @IBAction func defend() {
        fight(heroChoice: "defend")
    }
    
    @IBAction func trick() {
        fight(heroChoice: "trick")
    }
    
    
}
