//
//  crouchStuff.swift
//  Gigapet
//
//  Created by Kashfa Talukdar on 07/02/2016.
//  Copyright © 2016 Kashfa Talukdar. All rights reserved.
//

import Foundation
import UIKit
class crouchStuff : petImg {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        PlayIdleAnimation()
    }
    
    override func PlayIdleAnimation() {
    
        self.image = UIImage(named: "crouch")
        self.animationImages = nil
        
        var CImgArray = [UIImage]()
        for x in 1..<4 {
            let img = UIImage(named:"idle (\(x))-3")
            CImgArray.append(img!)
        }
        self.animationImages = CImgArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 0
        self.startAnimating()
        

    }
    override func playDeathAnimation() {
        
        self.image = UIImage(named: "dead (5)-2")
        self.animationImages = nil
        
        
        var DImgArray = [UIImage]()
       for x in 1..<4{
            let img = UIImage(named:"dead (\(x))-2")
            DImgArray.append(img!)
        }
        
        self.animationImages = DImgArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 1
        self.startAnimating()
      

    }
    
}
