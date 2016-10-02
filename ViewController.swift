//
//  ViewController.swift
//  Gigapet
//
//  Created by Kashfa Talukdar on 02/02/2016.
//  Copyright © 2016 Kashfa Talukdar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var crouchImg: UIImageView!

    @IBOutlet weak var creatureImg: UIImageView!
    
    @IBOutlet weak var foodImg: DragImg!
    @IBOutlet weak var fruitImg: DragImg!
    @IBOutlet weak var heartImg: DragImg!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        var CImgArray = [UIImage]()
        for var x = 1; x<=4; x++ {
            let img = UIImage(named:"idle (\(x))")
            CImgArray.append(img!)
        }
        
        creatureImg.animationImages = CImgArray
        creatureImg.animationDuration = 0.8
        creatureImg.animationRepeatCount = 0
        creatureImg.startAnimating()
        
        
        var DImgArray = [UIImage]()
        for var x = 1; x<=4; x++ {
            let img = UIImage(named:"idle (\(x))-3")
            DImgArray.append(img!)
        }
        
        crouchImg.animationImages = DImgArray
        crouchImg.animationDuration = 0.8
        crouchImg.animationRepeatCount = 0
        crouchImg.startAnimating()
        

        
        
    }

    


}

