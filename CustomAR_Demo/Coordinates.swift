//
//  Coordinates.swift
//  CustomAR_Demo
//
//  Created by landixing on 2017/7/20.
//  Copyright © 2017年 WJQ. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

func randomFloat(min: Float, max: Float) -> Float{
    return (Float(arc4random()) / 0xFFFFFFFF) * (max - min) + min
}

//MARK: -- AR 坐标
struct myCameraCoordinates{
    var x = Float()
    var y = Float()
    var z = Float()
}

func getCameraCoordinates(sceneView: ARSCNView) -> myCameraCoordinates {
    let cameraTransiton = sceneView.session.currentFrame?.camera.transform
    let cameraCoordinates = MDLTransform(matrix: cameraTransiton!)
    var cc = myCameraCoordinates()
    cc.x = cameraCoordinates.translation.x
    cc.y = cameraCoordinates.translation.y
    cc.z = cameraCoordinates.translation.z
    return cc
}
