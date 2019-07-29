//
//  ViewController.swift
//  TheTasteV0.0.1
//
//  Created by Ziyu on 2019/5/13.
//  Copyright © 2019年 ARTheTaste. All rights reserved.
//
import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    var heartNode: SCNNode?
    var appleNode: SCNNode?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        
        sceneView.autoenablesDefaultLighting = true
        
        let heartScene = SCNScene(named: "art.scnassets/heart.scn")
        let appleScene = SCNScene(named: "art.scnassets/apple.scn")
        
        heartNode = heartScene?.rootNode
        appleNode = appleScene?.rootNode
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARImageTrackingConfiguration()
        
        if let trackingImages = ARReferenceImage.referenceImages(inGroupNamed: "Dishes", bundle: Bundle.main){
            
            configuration.trackingImages = trackingImages
            configuration.maximumNumberOfTrackedImages = 2
        }

        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor{
            
            let size = imageAnchor.referenceImage.physicalSize
            let plane = SCNPlane(width: size.width, height: size.height)
            plane.firstMaterial?.diffuse.contents = UIColor.white.withAlphaComponent(0.5)
            plane.cornerRadius = 0.005
            let planeNode = SCNNode(geometry: plane)
            planeNode.eulerAngles.x = -.pi / 2
            node.addChildNode(planeNode)
            
            //if let shapeNode = appleNode {
            //    node.addChildNode(shapeNode)
            //}
            
            var shapeNode: SCNNode?
            switch imageAnchor.referenceImage.name{
                
            case DishType.dumpling.rawValue :
                shapeNode = heartNode
                
            case DishType.rolls.rawValue :
                shapeNode = appleNode
                
            default:
                break
            }
            
            if imageAnchor.referenceImage.name == "dumpling"{
                shapeNode = heartNode
            }
            else{
                shapeNode = appleNode
            }
            
            let shapeSpin = SCNAction.rotateBy(x: 0, y: 2 * .pi, z: 0, duration: 10)
            let repeatSpin = SCNAction.repeatForever(shapeSpin)
            shapeNode?.runAction(repeatSpin)
            
            guard let shape = shapeNode else {return nil}
            node.addChildNode(shape)
        }
        return node
        
    }
    enum DishType : String {
        
        case rolls = "rolls"
        case dumpling = "dumpling"
        //case kebab = "kebab"
        //case friedRice = "friedRice"
    }
}
