//
//  Expression.swift
//  Face
//
//  Created by SHUAI SHAO on 16/8/8.
//  Copyright © 2016年 SHUAI SHAO. All rights reserved.
//

import Foundation

struct  Expression{
    // 皱眉、惊讶、正常
    enum Brow {
        case angry
        case surprise
        case normal
    }
    
    // 眼睛睁开、闭上
    enum Eye{
        case open
        case close
    }
    
    // 嘴 笑、不开心、正常
    enum Mouth{
        case smile
        case normal
        case unhappy
    }
    var brow: Brow
    var eye: Eye
    var mouth: Mouth
}