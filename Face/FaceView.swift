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
    
    
   
    @IBInspectable
    // 定义可动范围
    var scale:CGFloat = 0.9{
        didSet{
          self.setNeedsDisplay()
        }
    }
    @IBInspectable
    var eye:Expression.Eye = Expression.Eye.open{
        didSet{
          self.setNeedsDisplay()
        }
    }
    @IBInspectable
    var mouth:Expression.Mouth = Expression.Mouth.smile{
        didSet{
            self.setNeedsDisplay()
        }
    }
    @IBInspectable
    var brow:Expression.Brow = Expression.Brow.normal{
        didSet{
           self.setNeedsDisplay()
        }
    }
    
    
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
    // 定义正常表情的 左眉毛 左坐标
    private var normalStartL:CGPoint{
        return CGPoint(x: faceCenter.x - faceRadius / 2, y: faceCenter.y - faceRadius / 2 )
    }
    // 定义正常表情的 左眉毛 右坐标
    private var normalEndL:CGPoint{
        return CGPoint(x: faceCenter.x - faceRadius / 4, y: faceCenter.y - faceRadius / 2)
    }
    // 定义正常表情的 右眉毛 左坐标
    private var normalStartR:CGPoint{
        return CGPoint(x: faceCenter.x + faceRadius / 2, y: faceCenter.y - faceRadius / 2)
    }
    // 定义正常表情的 右眉毛 右坐标
    private var normalEndR:CGPoint{
        return CGPoint(x: faceCenter.x + faceRadius / 4, y: faceCenter.y - faceRadius / 2)
    }
    // 定义睁开眼睛的 左眼睛 圆心
    private var normalEyeL:CGPoint{
        return CGPoint(x: (normalEndL.x - normalStartL.x) / 2 + normalStartL.x , y: faceCenter.y - faceRadius/4 )
    }
    // 定义睁开眼睛的 右眼睛 圆心
    private var normalEyeR:CGPoint{
        return CGPoint(x: (normalEndR.x - normalStartR.x) / 2 + normalStartR.x , y: faceCenter.y - faceRadius/4 )
    }
    // 定义眼睛的 半径
    private var normalEyeRadius:CGFloat{
        return faceRadius * 0.15
    }
    // 定义笑嘴 四个点
    private var smileStartPoint:CGPoint{
        return CGPoint(x: faceCenter.x - faceRadius / 4 , y: faceCenter.y + faceRadius / 4)
    }
    private var smileEndPoint:CGPoint{
        return CGPoint(x: faceCenter.x + faceRadius / 4 , y: faceCenter.y + faceRadius / 4)
    }
    private var smileControlPoint1:CGPoint{
        return CGPoint(x: faceCenter.x - faceRadius / 6 , y: faceCenter.y + faceRadius / 3)
    }
    private var smileControlPoint2:CGPoint{
        return CGPoint(x: faceCenter.x + faceRadius / 6 , y: faceCenter.y + faceRadius / 3)
    }
    
    // 画脸
    private func pathForCircleCenteredAtPoint(midPoint: CGPoint, withRadius radius: CGFloat) -> UIBezierPath
    {
        let path = UIBezierPath(
            arcCenter: midPoint,
            radius: radius,
            startAngle: 0.0,
            endAngle: CGFloat(2*M_PI),
            clockwise: false
        )
        path.lineWidth = 5.0
        return path
    }
    // 正常的 左眉毛
    private func pathForNoramalLeftBrow(startL: CGPoint, endL: CGPoint) -> UIBezierPath
    {
        var leftBrowPath = UIBezierPath()
        leftBrowPath.moveToPoint(startL)
        leftBrowPath.addLineToPoint(endL)
        if brow == Expression.Brow.surprise{
            leftBrowPath = UIBezierPath()
            leftBrowPath.moveToPoint(startL)
            leftBrowPath.addLineToPoint(CGPoint(x: endL.x, y: endL.y - faceRadius * 0.2))
        }
        if brow == Expression.Brow.angry{
            leftBrowPath = UIBezierPath()
            leftBrowPath.moveToPoint(CGPoint(x: startL.x, y: startL.y - faceRadius * 0.2))
            leftBrowPath.addLineToPoint(endL)
        }
        leftBrowPath.lineWidth = 5.0
        
        return leftBrowPath
    }
    // 正常的 右眉毛
    private func pathForNoramalRightBrow(startR: CGPoint, endR: CGPoint) -> UIBezierPath
    {
        var rightBrowPath = UIBezierPath()
        rightBrowPath.moveToPoint(startR)
        rightBrowPath.addLineToPoint(endR)
        if brow == Expression.Brow.surprise{
            rightBrowPath = UIBezierPath()
            rightBrowPath.moveToPoint(startR)
            rightBrowPath.addLineToPoint(CGPoint(x: endR.x, y: endR.y - faceRadius * 0.2))
        }
        if brow == Expression.Brow.angry{
            rightBrowPath = UIBezierPath()
            rightBrowPath.moveToPoint(CGPoint(x: startR.x, y: startR.y - faceRadius * 0.2))
            rightBrowPath.addLineToPoint(endR)
        }
        rightBrowPath.lineWidth = 5.0
        
        return rightBrowPath
    }
    // 正常的 左眼睛
    private func pathForLeftEye(midPoint: CGPoint, withRadius radius: CGFloat) -> UIBezierPath
    {
        var leftEyePath = UIBezierPath(
            arcCenter: midPoint,
            radius: radius,
            startAngle: 0.0,
            endAngle: CGFloat(2*M_PI),
            clockwise: false
        )
        
        if eye == Expression.Eye.close{
            leftEyePath = UIBezierPath()
            leftEyePath.moveToPoint(CGPoint(x: faceCenter.x - faceRadius * 0.3, y: faceCenter.y - faceRadius / 3))
            leftEyePath.addLineToPoint(CGPoint(x: faceCenter.x - faceRadius * 0.5, y: faceCenter.y - faceRadius / 3))
        }
        
        leftEyePath.lineWidth = 5.0
        return leftEyePath
    }
    // 正常的 右眼睛
    private func pathForRightEye(midPoint: CGPoint, withRadius radius: CGFloat) -> UIBezierPath
    {
        var rightEyePath = UIBezierPath(
            arcCenter: midPoint,
            radius: radius,
            startAngle: 0.0,
            endAngle: CGFloat(2*M_PI),
            clockwise: false
        )
        
        if eye == Expression.Eye.close{
            rightEyePath = UIBezierPath()
            rightEyePath.moveToPoint(CGPoint(x: faceCenter.x + faceRadius * 0.3, y: faceCenter.y - faceRadius / 3))
            rightEyePath.addLineToPoint(CGPoint(x: faceCenter.x + faceRadius * 0.5, y: faceCenter.y - faceRadius / 3))
        }
        rightEyePath.lineWidth = 5.0
        return rightEyePath
    }
    // 笑的 嘴
    private func pathForSmile(endPoint: CGPoint, controlPoint1: CGPoint, controlPoint2: CGPoint) -> UIBezierPath{
        var smilePath = UIBezierPath()
        smilePath.moveToPoint(smileStartPoint)
        smilePath.addCurveToPoint(
            endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2
        )
        if mouth == Expression.Mouth.normal{
            smilePath = UIBezierPath()
            smilePath.moveToPoint(smileStartPoint)
            smilePath.addLineToPoint(smileEndPoint)
            
        }
        else if mouth == Expression.Mouth.unhappy{
            smilePath = UIBezierPath()
            smilePath.moveToPoint(smileStartPoint)
            smilePath.addCurveToPoint(
                endPoint, controlPoint1: CGPoint(x:controlPoint1.x,y: controlPoint1.y - 2 * (faceRadius / 3)), controlPoint2: CGPoint(x:controlPoint2.x,y: controlPoint2.y - 2 * (faceRadius / 3))
            )
        }
        smilePath.lineWidth = 5.0
        return smilePath
        
        
    }
    override func drawRect(rect: CGRect)
    {
        UIColor.blueColor().set()
        pathForCircleCenteredAtPoint(faceCenter, withRadius: faceRadius).stroke()
        pathForNoramalLeftBrow(normalStartL, endL: normalEndL).stroke()
        pathForNoramalLeftBrow(normalStartR, endL: normalEndR).stroke()
        pathForLeftEye(normalEyeL, withRadius: normalEyeRadius).stroke()
        pathForRightEye(normalEyeR, withRadius: normalEyeRadius).stroke()
        pathForSmile(smileEndPoint, controlPoint1: smileControlPoint1, controlPoint2: smileControlPoint2).stroke()
        

    }

}
