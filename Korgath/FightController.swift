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
        heroLife.backgroundColor?.withAlphaComponent(0.5)
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "battleground1.jpg")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        //        appel du clacul pv à afficher au lancement
        pvActualHero(damage: 0)
        pvActualEnnemi(damage: 0)
        guard let path = Bundle.main.path(forResource: "fightMusic", ofType: "mp3")else{return}
        let soundURl = URL(fileURLWithPath: path)
        player2 = try? AVAudioPlayer(contentsOf: soundURl)
        player2.prepareToPlay()
        player2.numberOfLoops = -1
        player2.volume = 0.6
        player2.play()
        //player2.pause()
        //player2.stop()
        
    }
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        player2.stop()
        if (player != nil) {
            player.stop()
        }
        super.present(viewControllerToPresent, animated: flag, completion: completion)
        
    }

    
    //    début de mon code spécifique
    
    var pvMax = ["pvMaxHero": 100, "pvMaxEnnemi": 100]
    var pvActual = ["pvHero": 100, "pvEnnemi": 100]
    var player:AVAudioPlayer!
    var player2:AVAudioPlayer!
    
    @IBOutlet weak var heroLife: UILabel!
    @IBOutlet weak var ennemiLife: UILabel!
    @IBOutlet weak var combatLog: UILabel!
    
    func initPlayer (name: String, type: String){
        guard let path = Bundle.main.path(forResource: name, ofType: type)else{return}
        let soundURl = URL(fileURLWithPath: path)
        player = try? AVAudioPlayer(contentsOf: soundURl)
        player.prepareToPlay()
        player.play()
        //player.pause()
        //player.stop()
        
    }
    
    func pvActualHero(damage: Int) {
        pvActual["pvHero"]! -= damage
        if pvActual["pvHero"]! < 0 {
            pvActual["pvHero"] = 0
        }
        
        let quoteLifeH = "\(String(describing: pvActual["pvHero"]!)) / \(String(describing: pvMax["pvMaxHero"]!))"
        
        heroLife.text = quoteLifeH
        
        if pvActual["pvHero"]! == 0 {
            //            switch view
            
            switchController(id: "GvcLoose")
            
        }
        
        
    }
    
    func pvActualEnnemi(damage: Int) {
        pvActual["pvEnnemi"]! -= damage
        if pvActual["pvEnnemi"]! < 0 {
            pvActual["pvEnnemi"] = 0
        }
        
        let quoteLifeE = "\(String(describing: pvActual["pvEnnemi"]!)) / \(String(describing: pvMax["pvMaxEnnemi"]!))"
        
        ennemiLife.text = quoteLifeE
        
        if pvActual["pvEnnemi"]! == 0 {
            //            switch view
            switchController(id: "GvcWin")
            
        }
        
        
    }
    
    func switchController(id: String) {
        player2.stop()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: id)
        self.present(controller, animated: true, completion: nil)
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
            initPlayer(name: "attackSword", type: "wav")
            
        } else if (heroChoice == "attack" && ennemiChoice == "defend"){
            heroDamage += dmgCrit
            //            text combat log
            combatLog.text = "Korgath \(heroChoice)! \nThe Knight \(ennemiChoice)! \nKorgath incur a loss of \(dmgCrit) PV!"
            initPlayer(name: "defendKnight", type: "m4a")
            
        } else if (heroChoice == "attack" && ennemiChoice == "trick"){
            ennemiDamage += dmgCrit
            //    WINN e = damage +5
            combatLog.text = "Korgath \(heroChoice)! \nThe Knight \(ennemiChoice)! \nThe Knight incur a loss of \(dmgCrit) PV!"
            initPlayer(name: "attackOrc", type: "wav")
            
        } else if (heroChoice == "defend" && ennemiChoice == "attack"){
            ennemiDamage += dmgCrit
            //    WINN e = damage +5
            combatLog.text = "Korgath \(heroChoice)! \nThe Knight \(ennemiChoice)! \nThe Knight incur a loss of \(dmgCrit) PV!"
            initPlayer(name: "defendOrc", type: "m4a")
            
        } else if (heroChoice == "defend" && ennemiChoice == "trick"){
            heroDamage += dmgCrit
            //    LOOSE h = damage +5
            combatLog.text = "Korgath \(heroChoice)! \nThe Knight \(ennemiChoice)! \nKorgath incur a loss of \(dmgCrit) PV!"
            initPlayer(name: "trickKnight", type: "m4a")
            
        } else if (heroChoice == "trick" && ennemiChoice == "attack"){
            heroDamage += dmgCrit
            //    LOOSE h = damage +5
            combatLog.text = "Korgath \(heroChoice)! \nThe Knight \(ennemiChoice)! \nKorgath incur a loss of \(dmgCrit) PV!"
            initPlayer(name: "attackKnight", type: "m4a")
            
        } else if (heroChoice == "trick" && ennemiChoice == "defend"){
            ennemiDamage += dmgCrit
            //    WINN e = damage +5
            combatLog.text = "Korgath \(heroChoice)! \nThe Knight \(ennemiChoice)! \nThe Knight incur a loss of \(dmgCrit) PV!"
            initPlayer(name: "trickOrc", type: "wav")
            
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
