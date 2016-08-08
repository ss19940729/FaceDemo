//
//  FaceView.swift
//  Face
//
//  Created by SHUAI SHAO on 16/8/5.
//  Copyright © 2016年 SHUAI SHAO. All rights reserved.
//

import UIKit
@IBDesignable

class FaceView: UIView {
    
    
    var expression:Expression?
    
    let scale:CGFloat = 0.9
    // 定义微笑
    var mouthCurvature: Double = 1
    
    // 定义脸的半径
    private var faceRadius: CGFloat{
        return min(bounds.size.width/2, bounds.size.height/2) * scale
    }
    // 定义中点
    private var faceCenter:CGPoint{
        return CGPoint(x:self.bounds.width/2, y:self.bounds.height/2)
    }
    



}
