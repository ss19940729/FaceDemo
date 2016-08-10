//
//  FaceButtonController.swift
//  Face
//
//  Created by SHUAI SHAO on 16/8/10.
//  Copyright © 2016年 SHUAI SHAO. All rights reserved.
//

import UIKit

class FaceButtonController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationItem.title = "Emotions"
    
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        let identitify = segue.identifier
        var targetVc:ViewController
        
        
        if let segueID = identitify{
            if segueID == "Angry"{
                targetVc = (segue.destinationViewController as? ViewController)!
                targetVc.expression = Expression(brow: Expression.Brow.angry, eye: Expression.Eye.close, mouth: Expression.Mouth.unhappy)
                targetVc.navigationItem.title = "Angry"
        }
            else if segueID == "Smile"{
                targetVc = (segue.destinationViewController as? ViewController)!
                targetVc.expression = Expression(brow: Expression.Brow.normal, eye: Expression.Eye.open, mouth: Expression.Mouth.smile)
                targetVc.navigationItem.title = "Smile"
        }
            else if segueID == "Surprise"{
                targetVc = (segue.destinationViewController as? ViewController)!
                targetVc.expression = Expression(brow: Expression.Brow.surprise, eye: Expression.Eye.open, mouth: Expression.Mouth.normal)
                targetVc.navigationItem.title = "Surprise"
            }
        
    }
        
        
    
    }
}
