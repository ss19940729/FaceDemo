//
//  ViewController.swift
//  Face
//
//  Created by SHUAI SHAO on 16/8/5.
//  Copyright © 2016年 SHUAI SHAO. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var expression = Expression(brow: Expression.Brow.surprise, eye: Expression.Eye.close, mouth: Expression.Mouth.normal)
    
   

    @IBOutlet weak var faceView: FaceView!{
        
        
        didSet{
          let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(scaleFace(_:)))
            faceView.addGestureRecognizer(pinchGesture)
            
            //点击眼睛的手势
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(changeEyeAction(_:)))
            faceView.addGestureRecognizer(tapGesture)
            
            let upSwipeGesture = createSwipeGesture(.Up)
            faceView.addGestureRecognizer(upSwipeGesture)
            
            let downSwipeGesture = createSwipeGesture(.Down)
            faceView.addGestureRecognizer(downSwipeGesture)
            
            
            let browRotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(changeBrowAction(_:)))
            faceView.addGestureRecognizer(browRotationGesture)
            
            
        
        }
    
    }
    
    func createSwipeGesture(direction:UISwipeGestureRecognizerDirection) -> UISwipeGestureRecognizer{
        let upSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(changeMouthAction(_:)))
        upSwipeGesture.numberOfTouchesRequired = 1
        upSwipeGesture.direction = direction
        
        return upSwipeGesture
    }
    
    func scaleFace(gesture:UIPinchGestureRecognizer) -> Void {
        faceView.scale = gesture.scale

    }
    func changeEyeAction(gesture:UITapGestureRecognizer) -> Void {

        if faceView.eye == .close{
            faceView.eye = Expression.Eye.open
        }else{
            faceView.eye = Expression.Eye.close
        }
        
    }
    
    func changeMouthAction(gesture:UISwipeGestureRecognizer) -> Void {
        if faceView.mouth == .smile{
            if(gesture.direction == .Up){
                faceView.mouth = Expression.Mouth.normal
            }
            
        }
        else if(faceView.mouth == .normal){
            if(gesture.direction == .Up){
                faceView.mouth = Expression.Mouth.unhappy
            }
            else if (gesture.direction == .Down){
                faceView.mouth = Expression.Mouth.smile
            }
            
        }
        else{
            if(gesture.direction == .Down){
                faceView.mouth = Expression.Mouth.normal
            }
            
        }
    }
    
    func changeBrowAction(gesture:UIRotationGestureRecognizer) -> Void{
        
        if gesture.rotation < -CGFloat(M_PI/4){
            faceView.brow = Expression.Brow.angry
        }
        else if (gesture.rotation > CGFloat(M_PI / 4)){
            faceView.brow = Expression.Brow.surprise
        }else{
            faceView.brow = Expression.Brow.normal

        }
        
//        if faceView.brow == .normal{
//            // 顺时针
//            if gesture.rotation > CGFloat(M_PI/4)  {
//                faceView.brow = Expression.Brow.angry
//            }
//            else if gesture.rotation < -CGFloat(M_PI/4) {
//                faceView.brow = Expression.Brow.surprise
//            }
//        }
//        else if faceView.brow == .angry{
//            print("gesture.rotation:\(gesture.rotation);-CGFloat(M_PI/4):\(-CGFloat(M_PI/4))")
//            if gesture.rotation < -CGFloat(M_PI/4){
//                faceView.brow = Expression.Brow.normal
//            }
//            
//            else if (-CGFloat(M_PI / 2) < gesture.rotation && gesture.rotation < -CGFloat(M_PI / 2)){
//                faceView.brow = Expression.Brow.surprise
//            }
//        }
//        else if faceView.brow == .surprise{
//            if gesture.rotation > CGFloat(M_PI/4){
//                faceView.brow = Expression.Brow.normal
//            }
//            else if (gesture.rotation > CGFloat(M_PI/4) && gesture.rotation < CGFloat(M_PI/2)){
//                faceView.brow = Expression.Brow.angry
//            }
//        }
    
        
        
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        faceView.backgroundColor = UIColor.orangeColor()
      
        updateUI()
        
    }

    
    func updateUI() -> Void {
        
        faceView.brow = expression.brow
        faceView.eye = expression.eye
        faceView.mouth = expression.mouth
        
//        faceView.setNeedsDisplay()
    }
   


}

