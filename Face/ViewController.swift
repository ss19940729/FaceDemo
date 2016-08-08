//
//  ViewController.swift
//  Face
//
//  Created by SHUAI SHAO on 16/8/5.
//  Copyright © 2016年 SHUAI SHAO. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var expression = Expression(brow: Expression.Brow.angry, eye: Expression.Eye.close, mouth: Expression.Mouth.normal){
        didSet{
         updateUI()
        }
    }
    
   

    @IBOutlet weak var faceView: FaceView!{
        didSet{
         
        }
    
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        faceView.backgroundColor = UIColor.redColor()
        faceView.expression = expression
        expression.brow = Expression.Brow.angry
        
    }

    
    func updateUI() -> Void {
        faceView.setNeedsDisplay()
    }
   


}

