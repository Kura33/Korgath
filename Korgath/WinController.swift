//
//  Win.swift
//  Korgath
//
//  Created by XAVIER CARLOS on 14/11/2019.
//  Copyright © 2019 Sebastien XAVIER CARLOS. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

class WinController: UIViewController {
     var player2:AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "battleground1.jpg")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        guard let path = Bundle.main.path(forResource: "winMusic", ofType: "mp3")else{return}
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
           super.present(viewControllerToPresent, animated: flag, completion: completion)
           
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
    

}
