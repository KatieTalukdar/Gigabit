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
    var timer : NSTimer!
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
        penalty1.hidden = true
        penalty2.hidden = true
        penalty3.hidden = true
        fruitImg.hidden = true
        foodImg.hidden = true
        heartImg.hidden = true
        livespanel.hidden = true
        restartBtn.hidden = true
        
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "itemDropped:", name: "onTargetDropped", object: nil)
        
     
        
        do {
            try musicPlayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath:NSBundle.mainBundle().pathForResource("cave-music", ofType: "mp3")!))
            try sfxBite = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bite", ofType: "wav")!))
            try sfxHeart = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("heart", ofType: "wav")!))
            
            try sfxSkull = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("skull", ofType: "wav")!))
            
            try sfxDeath = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("death", ofType: "wav")!))
            
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
    
    
    
   @IBAction func ifCrouchSelected(sender: AnyObject) {
    startTimer()
    penalty1.hidden = false
    penalty2.hidden = false
    penalty3.hidden = false
    fruitImg.hidden = false
    foodImg.hidden = false
    heartImg.hidden = false
    livespanel.hidden = false
    restartBtn.hidden = true
        openingCreature.hidden = true
        openingCrouch.hidden = true
        chooseLabel.hidden = true
        creatureImg.hidden = true
        bg.hidden = true
        crouchImg.hidden = false
        tiles.hidden = false
        heartImg.dropTarget = crouchImg
        foodImg.dropTarget = crouchImg
        fruitImg.dropTarget = crouchImg
        
    }



    @IBAction func ifCreatureSelected(sender: AnyObject) {
        startTimer()
        penalty1.hidden = false
        penalty2.hidden = false
        penalty3.hidden = false
        fruitImg.hidden = false
        foodImg.hidden = false
        heartImg.hidden = false
        livespanel.hidden = false
        restartBtn.hidden = true
        openingCreature.hidden = true
        openingCrouch.hidden = true
        chooseLabel.hidden = true
        creatureImg.hidden = false
        bg.hidden = false
        crouchImg.hidden = true
        tiles.hidden = true
        heartImg.dropTarget = creatureImg
        foodImg.dropTarget = creatureImg
        fruitImg.dropTarget = creatureImg
    }
    
    func itemDropped(notif : AnyObject){
        petHappy = true
        
        if currentValue == 0 {
            sfxHeart.play()
        }
        else{
            sfxBite.play()
        }
        
        foodImg.alpha = ALPHA_DIM
        foodImg.userInteractionEnabled = false
        
        heartImg.alpha = ALPHA_DIM
        heartImg.userInteractionEnabled = false
        
        fruitImg.alpha = ALPHA_DIM
        fruitImg.userInteractionEnabled = false

        startTimer()

    }
    
    
    func startTimer(){
       if timer != nil {
          timer.invalidate()
  }
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "changeGameState", userInfo: nil, repeats: true)
    }
    
    func changeGameState(){
        if !petHappy{
    penalties++
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
            heartImg.userInteractionEnabled = true
            
            foodImg.alpha = ALPHA_DIM
            foodImg.userInteractionEnabled = false
            
            fruitImg.alpha = ALPHA_DIM
            fruitImg.userInteractionEnabled = false
        }
        if rand == 1{
            foodImg.alpha = OPAQUE
            foodImg.userInteractionEnabled = true
            
            heartImg.alpha = ALPHA_DIM
            heartImg.userInteractionEnabled = false
            
            fruitImg.alpha = ALPHA_DIM
            fruitImg.userInteractionEnabled = false
        }
        if rand == 2{
            fruitImg.alpha = OPAQUE
            fruitImg.userInteractionEnabled = true
            
            foodImg.alpha = ALPHA_DIM
            foodImg.userInteractionEnabled = false
            
            heartImg.alpha = ALPHA_DIM
            heartImg.userInteractionEnabled = false
        }

        currentValue = rand
        petHappy = false
    }
    
        
    @IBAction func whenRestartPressed(sender: AnyObject) {
        creatureImg.PlayIdleAnimation()
        crouchImg.PlayIdleAnimation()
        penalties = 0
        penalty1.alpha = ALPHA_DIM
        penalty2.alpha = ALPHA_DIM
        penalty3.alpha = ALPHA_DIM
        creatureImg.hidden = true
        crouchImg.hidden = true
        chooseLabel.hidden = false
        openingCrouch.hidden = false
        openingCreature.hidden = false
        restartBtn.hidden = true
        bg.hidden = false
        tiles.hidden = true
        livespanel.hidden = true
        fruitImg.hidden = true
        foodImg.hidden = true
        heartImg.hidden = true
        penalty1.hidden = true
        penalty2.hidden = true
        penalty3.hidden = true
        
    }
    func gameOver(){
        timer.invalidate()
            creatureImg.playDeathAnimation()
            crouchImg.playDeathAnimation()
        sfxDeath.play()
        restartBtn.hidden = false

    
    }
  }


