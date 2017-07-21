//
//  SomeScenceViewController.swift
//  CustomAR_Demo
//
//  Created by landixing on 2017/7/20.
//  Copyright © 2017年 WJQ. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class SomeScenceViewController: UIViewController ,ARSCNViewDelegate, btnClickDelegate{

    // 来增强相机通过 3D SceneKit 所捕捉到的内容并展  AR 效果的 个 view
    @IBOutlet var sceneView: ARSCNView!
    
    lazy var scrollviewBtn : ScrollViewButton = {
        let height: CGFloat = 45
        let scrollbtn = ScrollViewButton(frame: CGRect(x: 0, y: self.view.bounds.height - height - 45, width: self.view.bounds.width, height: height))
        scrollbtn.btnNames = ["cube","candle","chair","cup","lamp","vase"]
        scrollbtn.delegate = self
        return scrollbtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //显示统计fps和时间等信息
        sceneView.showsStatistics = true
        
        //allows the user to manipulate the camera(允许用户操作相机)
        sceneView.allowsCameraControl = true
        
        //自动调节亮度
        sceneView.automaticallyUpdatesLighting = true
        
        view.insertSubview(scrollviewBtn, aboveSubview: sceneView)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingSessionConfiguration()
        //        configuration.planeDetection = .horizontal
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }

    
    func btnClick(btn: UIButton) {
        
        switch btn.tag {
        case 0:
            do {
                let cc = getCameraCoordinates(sceneView: self.sceneView)

                    let cubeNode = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0))
                    //         cubeNode.position = SCNVector3(0, 0, zCoords)//This is in meters
                    cubeNode.position = SCNVector3(cc.x, cc.y, cc.z) //This is in meters
                self.sceneView.scene.rootNode.addChildNode(cubeNode)
            }
            break
        case 1:

               let node = createNode()
                guard let scene = SCNScene(named:"candle.scn", inDirectory: "Models.scnassets/candle") else { return }
                createSceneWithNode(node, scene)
        case 2:
                let chair = createNode()
                guard let scene = SCNScene(named:"chair.scn", inDirectory: "Models.scnassets/chair") else { return }
                createSceneWithNode(chair, scene)
        case 3:
                let cupNode = createNode()
                guard let virtualObjectScene = SCNScene(named: "cup.scn", inDirectory: "Models.scnassets/cup") else { return}
                createSceneWithNode(cupNode, virtualObjectScene)
                 cupNode.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 2, z: 0, duration: 1)))
        case 4:
                let node = createNode()
                guard let virtualObjectScene = SCNScene(named: "lamp.scn", inDirectory: "Models.scnassets/lamp") else {return}
                createSceneWithNode(node, virtualObjectScene)

            break
        case 5:
                let node = createNode()
                
                guard let virtualObjectScene = SCNScene(named: "vase.scn", inDirectory: "Models.scnassets/vase") else {return}
                createSceneWithNode(node, virtualObjectScene)
            
        default:
            break
        }
    }
    
   
    
    @IBAction func isZoomed(_ sender: UIButton) {
        
        if sender.isSelected {
            //allows the user to manipulate the camera(允许用户操作相机)
//            sceneView.allowsCameraControl = true
        }else{
            //allows the user to manipulate the camera(允许用户操作相机)
//            sceneView.allowsCameraControl = false
            
        }
    }
    
    
   
  
    fileprivate func createNode()-> SCNNode {
        let node = SCNNode()
        let cc = getCameraCoordinates(sceneView: self.sceneView)
        node.position = SCNVector3(cc.x, cc.y, cc.z)
        return node
    }
    
    fileprivate func createSceneWithNode(_ node: SCNNode, _ scnScene: SCNScene) {
        
        let  scene = scnScene
        let wrapperNode = SCNNode()
        
        for child in scene.rootNode.childNodes {
            child.geometry?.firstMaterial?.lightingModel = .physicallyBased
            wrapperNode.addChildNode(child)
        }
        node.addChildNode(wrapperNode)
        self.sceneView.scene.rootNode.addChildNode(node)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  

}
