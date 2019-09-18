//
//  ViewController.swift
//  ImageTrackV02
//
//  Created by LaoBoiii on 2019/8/18.
//  Copyright © 2019年 theTaste. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ARViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    
    
    struct videoContainer {
        var targetName = String()
        var videoPlayer = AVPlayer()
        //var node : SCNNode?
        var anchor : ARAnchor?
        //var dead = false
    }
    
    var videoContainers: Array<videoContainer> = Array()
   // var anchorContainter : Array<ARAnchor> = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        sceneView.autoenablesDefaultLighting = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARImageTrackingConfiguration()
        if let trackingImages = ARReferenceImage.referenceImages(inGroupNamed: "menu", bundle: Bundle.main){
            configuration.trackingImages = trackingImages
            configuration.maximumNumberOfTrackedImages = 22
        }
        
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        /*for vc in videoContainers {
            vc.videoPlayer.pause()
            //sceneView.session.remove(anchor: vc.anchor!)
            
            if let imageAnchor = vc.anchor as? ARImageAnchor{
                sceneView.session.remove(anchor: imageAnchor)
                print("removed")
            }
            
        }
        */
        /*
        for aa in anchorContainter /*sceneView.session.currentFrame!.anchors*/ {
            sceneView.session.remove(anchor: aa)
            print("AAA REMOVED")
        }*/
        
        videoContainers.removeAll()
        
        //sceneView.scene.rootNode.enumerateChildNodes {
        //    (node, stop) in node.removeFromParentNode()
        //}
        let configuration = ARImageTrackingConfiguration()
    
        sceneView.session.pause()
        sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
            node.removeFromParentNode()
        }
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        if let vaildAnchor = anchor as? ARImageAnchor{
            //anchorContainter.append(vaildAnchor)
            
            /*for (index, vc) in videoContainers.enumerated(){
                if(vc.targetName == vaildAnchor.referenceImage.name){
                    //sceneView.session.remove(anchor: vaildAnchor)
                    node.removeFromParentNode()
                    videoContainers.remove(at: index)
                }
            }*/
            
            let videoPlayerNode = SCNNode()
            var videoPlayer = AVPlayer()
                
            if let targetName = vaildAnchor.referenceImage.name, let validURL = Bundle.main.url(forResource: targetName, withExtension: "mp4", subdirectory: "/art.scnassets"){
                videoPlayer = (AVPlayer(url: validURL))
                videoPlayer.play()
            }
                
            let videoPlayerGeometry = SCNPlane(width: vaildAnchor.referenceImage.physicalSize.width, height: vaildAnchor.referenceImage.physicalSize.height)
                
            videoPlayerGeometry.firstMaterial?.diffuse.contents = videoPlayer
            videoPlayerNode.geometry = videoPlayerGeometry
            videoPlayerNode.eulerAngles.x = -.pi / 2
            node.addChildNode(videoPlayerNode)
                
            let vc = videoContainer(targetName: vaildAnchor.referenceImage.name ?? "error", videoPlayer: videoPlayer, anchor: anchor)
            videoContainers.append(vc)


        }
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        
        if let vaildAnchor = anchor as? ARImageAnchor{
            
           // if node.isHidden == true{
           //     if let imageAnchor = anchor as? ARImageAnchor{
           //         sceneView.session.remove(anchor: imageAnchor)
           //     }
           // }
            
            /*for (index, vc) in videoContainers.enumerated(){
                if(vc.targetName == vaildAnchor.referenceImage.name){
                    sceneView.session.remove(anchor: vaildAnchor)
                    videoContainers.remove(at: index)
                }
            }*/
            for vc in videoContainers{
                if vc.targetName == vaildAnchor.referenceImage.name {
                    if (CMTimeGetSeconds(vc.videoPlayer.currentTime()) >=
                        CMTimeGetSeconds(vc.videoPlayer.currentItem!.duration)) {
                        vc.videoPlayer.seek(to: CMTime(seconds: 0, preferredTimescale: 60000) )
                    }
                    else if(node.isHidden) {
                        vc.videoPlayer.pause()
                    }
                    else {
                        vc.videoPlayer.play()
                    }
                    
                }
            }
        }
    }
    
    
    /*func createdVideoPlayerNodeFor(_ target: ARReferenceImage) -> SCNNode{
        
        let videoPlayerNode = SCNNode()
        
        let videoPlayerGeometry = SCNPlane(width: target.physicalSize.width, height: target.physicalSize.height)
        var videoPlayer = AVPlayer()
        
        if let targetName = target.name, let validURL = Bundle.main.url(forResource: targetName, withExtension: "mp4", subdirectory: "/art.scnassets"){
            videoPlayer = AVPlayer(url: validURL)
            videoPlayer.pause()
        }
        
        
        videoPlayerGeometry.firstMaterial?.diffuse.contents = videoPlayer
        videoPlayerNode.geometry = videoPlayerGeometry
        videoPlayerNode.eulerAngles.x = -.pi / 2
        return videoPlayerNode
    }*/
    
    /*override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
     guard let currentTouchLocation = touches.first?.location(in: self.sceneView), let hitTestResultNode = self.sceneView.hitTest(currentTouchLocation, options: nil).first?.node else { return }
     if
     
     }*/
    
}

