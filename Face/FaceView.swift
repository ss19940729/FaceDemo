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
    

    private struct Ratios {
        static let SkullRadiusToEyeOffset: CGFloat = 3
        static let SkullRadiusToEyeRadius: CGFloat = 10
        static let SkullRadiusToBrowOffset: CGFloat = 15
        static let SkullRadiusToBrowOffsetY:CGFloat = 30
        static let SkullRadiusToMouthWidth: CGFloat = 1
        static let SkullRadiusToMouthHeight: CGFloat = 3
        static let SkullRadiusToMouthOffset: CGFloat = 3
    }
    
    enum Eye {
        case Left
        case Right
    }
    
    
   func pathForCircleCenteredAtPoint(midPoint: CGPoint, withRadius radius: CGFloat) -> UIBezierPath
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
    
     func getEyeCenter(eye: Eye) -> CGPoint
    {
        let eyeOffset = faceRadius / Ratios.SkullRadiusToEyeOffset
        var eyeCenter = faceCenter
        eyeCenter.y -= eyeOffset
        switch eye {
        case .Left: eyeCenter.x -= eyeOffset
        case .Right: eyeCenter.x += eyeOffset
        }
        return eyeCenter
    }
    func getBrowPoint(eye: Eye, brow: Expression.Brow) -> (startX:CGFloat,endX:CGFloat,browPointY:CGFloat, browPointY2:CGFloat)
    {   // 眉毛Y 坐标
        var browPointY = getEyeCenter(.Right).y - Ratios.SkullRadiusToBrowOffsetY
        var browPointY2 = getEyeCenter(.Right).y - Ratios.SkullRadiusToBrowOffsetY
        
        var startX:CGFloat = 0
        var endX:CGFloat = 0
        if brow == Expression.Brow.normal{
        startX = eye == .Left ? getEyeCenter(.Left).x - Ratios.SkullRadiusToBrowOffset:getEyeCenter(.Right).x - Ratios.SkullRadiusToBrowOffset
        endX = eye == .Left ? getEyeCenter(.Left).x + Ratios.SkullRadiusToBrowOffset:getEyeCenter(.Right).x + Ratios.SkullRadiusToBrowOffset
        }
        else if brow == Expression.Brow.angry{
           browPointY += 50
            startX = eye == .Left ? getEyeCenter(.Left).x - Ratios.SkullRadiusToBrowOffset:getEyeCenter(.Right).x - Ratios.SkullRadiusToBrowOffset
            endX = eye == .Left ? getEyeCenter(.Left).x + Ratios.SkullRadiusToBrowOffset:getEyeCenter(.Right).x + Ratios.SkullRadiusToBrowOffset
        }
        else{
            
        }
     return (startX,endX,browPointY,browPointY2)
    }
    
    func pathForBrow(eye: Eye,brow:Expression.Brow?) -> UIBezierPath
    {
        var brwoExpress:Expression.Brow =  Expression.Brow.normal
        if brow != nil{
          brwoExpress = brow!
        }
        let path = UIBezierPath()
        let result  = getBrowPoint(eye, brow: brwoExpress)
        switch eye {
        case .Left:
            path.moveToPoint(CGPoint(x: result.startX, y: result.browPointY))
            path.addLineToPoint(CGPoint(x:result.endX, y: result.browPointY))
        case .Right:
            break
        }
        path.moveToPoint(CGPoint(x: result.startX, y: result.browPointY))
            
        path.addLineToPoint(CGPoint(x:result.endX, y: result.browPointY))
        path.lineWidth = 5.0
        return path
    }
    
     func pathForEye(eye: Eye) -> UIBezierPath
    {
        let eyeRadius = faceRadius / Ratios.SkullRadiusToEyeRadius
        let eyeCenter = getEyeCenter(eye)
        return pathForCircleCenteredAtPoint(eyeCenter, withRadius: eyeRadius)
    }
    
    func pathForMouth() -> UIBezierPath
    {
        let mouthWidth = faceRadius / Ratios.SkullRadiusToMouthWidth
        let mouthHeight = faceRadius / Ratios.SkullRadiusToMouthHeight
        let mouthOffset = faceRadius / Ratios.SkullRadiusToMouthOffset
        
        let mouthRect = CGRect(x: faceCenter.x - mouthWidth/2, y: faceCenter.y + mouthOffset, width: mouthWidth, height: mouthHeight)
        
        let smileOffset = CGFloat(max(-1, min(mouthCurvature, 1))) * mouthRect.height
        let start = CGPoint(x: mouthRect.minX, y: mouthRect.minY)
        let end = CGPoint(x: mouthRect.maxX, y: mouthRect.minY)
        let cp1 = CGPoint(x: mouthRect.minX + mouthRect.width / 3, y: mouthRect.minY + smileOffset)
        let cp2 = CGPoint(x: mouthRect.maxX - mouthRect.width / 3, y: mouthRect.minY + smileOffset)
        
        let path = UIBezierPath()
        path.moveToPoint(start)
        path.addCurveToPoint(end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = 5.0
        
        return path
    }

    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        UIColor.blueColor().set()
        pathForCircleCenteredAtPoint(faceCenter, withRadius: faceRadius).stroke()
        pathForEye(.Left).stroke()
        pathForEye(.Right).stroke()
        pathForMouth().stroke()
//        pathForBrow(.Left).stroke()
//        pathForBrow(.Right).stroke()
        
        pathForBrow(.Left, brow: expression?.brow).stroke()
        pathForBrow(.Right, brow: expression?.brow).stroke()
//        // Drawing code
    }


}
