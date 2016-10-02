//
//  ViewController.swift
//  Gigapet
//
//  Created by Kashfa Talukdar on 02/02/2016.
//  Copyright © 2016 Kashfa Talukdar. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController  {
    
    @IBOutlet weak var restartBtn: UIButton!
    
    @IBOutlet weak var bg: UIImageView!
    @IBOutlet weak var penalty1: UIImageView!
    @IBOutlet weak var crouchImg: crouchStuff!
 
    @IBOutlet weak var tiles: UIImageView!
    @IBOutlet weak var penalty2: UIImageView!

    @IBOutlet weak var penalty3: UIImageView!
    @IBOutlet weak var creatureImg: petImg!
    
    @IBOutlet weak var foodImg: DragImg!
    @IBOutlet weak var fruitImg: DragImg!
    @IBOutlet weak var heartImg: DragImg!
    
    @IBOutlet weak var chooseLabel: UILabel!
    @IBOutlet weak var openingCreature: UIButton!
    @IBOutlet weak var openingCrouch: UIButton!
    var penalties = 0
    let MAX_PENALTY = 3
    let ALPHA_DIM : CGFloat = 0.2
    let OPAQUE : CGFloat = 1.0
    var timer : Timer!
    var petHappy = false
    var currentValue :UInt32 = 0
    
    @IBOutlet weak var livespanel: UIImageView!
    var musicPlayer : AVAudioPlayer!
    var sfxBite : AVAudioPlayer!
    var sfxHeart : AVAudioPlayer!
    var sfxSkull : AVAudioPlayer!
    var sfxDeath : AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        penalty1.alpha = ALPHA_DIM
        penalty2.alpha = ALPHA_DIM
        penalty3.alpha = ALPHA_DIM
        penalty1.isHidden = true
        penalty2.isHidden = true
        penalty3.isHidden = true
        fruitImg.isHidden = true
        foodImg.isHidden = true
        heartImg.isHidden = true
        livespanel.isHidden = true
        restartBtn.isHidden = true
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.itemDropped(_:)), name: NSNotification.Name(rawValue: "onTargetDropped"), object: nil)
        
     
        
        do {
            try musicPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath:Bundle.main.path(forResource: "cave-music", ofType: "mp3")!))
            try sfxBite = AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "bite", ofType: "wav")!))
            try sfxHeart = AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "heart", ofType: "wav")!))
            
            try sfxSkull = AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "skull", ofType: "wav")!))
            
            try sfxDeath = AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "death", ofType: "wav")!))
            
            musicPlayer.prepareToPlay()
            musicPlayer.play()
            
            sfxBite.prepareToPlay()
            sfxHeart.prepareToPlay()
            sfxSkull.prepareToPlay()
            sfxDeath.prepareToPlay()
    
            
        }catch let err as NSError{
            print(err.debugDescription)
        }
    }
    
    
    
   @IBAction func ifCrouchSelected(_ sender: AnyObject) {
    startTimer()
    penalty1.isHidden = false
    penalty2.isHidden = false
    penalty3.isHidden = false
    fruitImg.isHidden = false
    foodImg.isHidden = false
    heartImg.isHidden = false
    livespanel.isHidden = false
    restartBtn.isHidden = true
        openingCreature.isHidden = true
        openingCrouch.isHidden = true
        chooseLabel.isHidden = true
        creatureImg.isHidden = true
        bg.isHidden = true
        crouchImg.isHidden = false
        tiles.isHidden = false
        heartImg.dropTarget = crouchImg
        foodImg.dropTarget = crouchImg
        fruitImg.dropTarget = crouchImg
        
    }



    @IBAction func ifCreatureSelected(_ sender: AnyObject) {
        startTimer()
        penalty1.isHidden = false
        penalty2.isHidden = false
        penalty3.isHidden = false
        fruitImg.isHidden = false
        foodImg.isHidden = false
        heartImg.isHidden = false
        livespanel.isHidden = false
        restartBtn.isHidden = true
        openingCreature.isHidden = true
        openingCrouch.isHidden = true
        chooseLabel.isHidden = true
        creatureImg.isHidden = false
        bg.isHidden = false
        crouchImg.isHidden = true
        tiles.isHidden = true
        heartImg.dropTarget = creatureImg
        foodImg.dropTarget = creatureImg
        fruitImg.dropTarget = creatureImg
    }
    
    func itemDropped(_ notif : AnyObject){
        petHappy = true
        
        if currentValue == 0 {
            sfxHeart.play()
        }
        else{
            sfxBite.play()
        }
        
        foodImg.alpha = ALPHA_DIM
        foodImg.isUserInteractionEnabled = false
        
        heartImg.alpha = ALPHA_DIM
        heartImg.isUserInteractionEnabled = false
        
        fruitImg.alpha = ALPHA_DIM
        fruitImg.isUserInteractionEnabled = false

        startTimer()

    }
    
    
    func startTimer(){
       if timer != nil {
          timer.invalidate()
  }
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(ViewController.changeGameState), userInfo: nil, repeats: true)
    }
    
    func changeGameState(){
        if !petHappy{
    penalties += 1
            sfxSkull.play()
        
     if penalties == 1 {
            penalty1.alpha = OPAQUE
            penalty2.alpha = ALPHA_DIM
        }else if penalties == 2 {
            penalty2.alpha = OPAQUE
            penalty3.alpha = ALPHA_DIM
        }else if penalties >= 3 {
            penalty3.alpha = OPAQUE
        }else{
            penalty1.alpha = ALPHA_DIM
            penalty2.alpha = ALPHA_DIM
            penalty3.alpha = ALPHA_DIM
            
        }
        if penalties >= MAX_PENALTY {
            timer.invalidate()
            gameOver()
        }
        }
        let rand = arc4random_uniform(3)
        if rand == 0{
            heartImg.alpha = OPAQUE
            heartImg.isUserInteractionEnabled = true
            
            foodImg.alpha = ALPHA_DIM
            foodImg.isUserInteractionEnabled = false
            
            fruitImg.alpha = ALPHA_DIM
            fruitImg.isUserInteractionEnabled = false
        }
        if rand == 1{
            foodImg.alpha = OPAQUE
            foodImg.isUserInteractionEnabled = true
            
            heartImg.alpha = ALPHA_DIM
            heartImg.isUserInteractionEnabled = false
            
            fruitImg.alpha = ALPHA_DIM
            fruitImg.isUserInteractionEnabled = false
        }
        if rand == 2{
            fruitImg.alpha = OPAQUE
            fruitImg.isUserInteractionEnabled = true
            
            foodImg.alpha = ALPHA_DIM
            foodImg.isUserInteractionEnabled = false
            
            heartImg.alpha = ALPHA_DIM
            heartImg.isUserInteractionEnabled = false
        }

        currentValue = rand
        petHappy = false
    }
    
        
    @IBAction func whenRestartPressed(_ sender: AnyObject) {
        creatureImg.PlayIdleAnimation()
        crouchImg.PlayIdleAnimation()
        penalties = 0
        penalty1.alpha = ALPHA_DIM
        penalty2.alpha = ALPHA_DIM
        penalty3.alpha = ALPHA_DIM
        creatureImg.isHidden = true
        crouchImg.isHidden = true
        chooseLabel.isHidden = false
        openingCrouch.isHidden = false
        openingCreature.isHidden = false
        restartBtn.isHidden = true
        bg.isHidden = false
        tiles.isHidden = true
        livespanel.isHidden = true
        fruitImg.isHidden = true
        foodImg.isHidden = true
        heartImg.isHidden = true
        penalty1.isHidden = true
        penalty2.isHidden = true
        penalty3.isHidden = true
        
    }
    func gameOver(){
        timer.invalidate()
            creatureImg.playDeathAnimation()
            crouchImg.playDeathAnimation()
        sfxDeath.play()
        restartBtn.isHidden = false

    
    }
  }


