//
//  PetImage.swift
//  Gigapet
//
//  Created by Kashfa Talukdar on 07/02/2016.
//  Copyright © 2016 Kashfa Talukdar. All rights reserved.
//

import Foundation
import UIKit

class petImg :UIImageView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        PlayIdleAnimation()
    }
    
    func PlayIdleAnimation() {
        self.image = UIImage(named: "creature")
        self.animationImages = nil
        
        
        var CImgArray = [UIImage]()
      for x in 1..<4 {
            let img = UIImage(named:"idle (\(x))")
            CImgArray.append(img!)
        }
        
        self.animationImages = CImgArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 0
        self.startAnimating()
        

    }
    
    func playDeathAnimation(){
        
        self.image = UIImage(named: "dead (5)")
        self.animationImages = nil
        
        
        var DImgArray = [UIImage]()
        for x in 1..<4 {
            let img = UIImage(named:"dead (\(x))")
            DImgArray.append(img!)
        }
        
        self.animationImages = DImgArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 1
        self.startAnimating()
        

    }
}
