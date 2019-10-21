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
    
    class videoContainer {
        var targetName = String()
        var player = AVPlayer()
        var node : SCNNode?
        var anchor : ARAnchor?
        var play = Bool()
        
        init(targetName : String, player : AVPlayer, node: SCNNode, anchor: ARAnchor, play: Bool) {
            
            self.targetName = targetName
            self.player = player
            self.node = node
            self.anchor = anchor
            self.play = play
        }
    
    }
    
    var videoContainers: Array<videoContainer> = Array()
    
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
            configuration.maximumNumberOfTrackedImages = 10
        }
        
        sceneView.session.run(configuration)
        
        //Google Analytics screen tracking
        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
        tracker.set(kGAIScreenName, value: "AR_page")

        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
        tracker.send(builder.build() as [NSObject : AnyObject])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        videoContainers.removeAll()
        
        let configuration = ARImageTrackingConfiguration()
    
        sceneView.session.pause()
        sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
            node.removeFromParentNode()
        }
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        if let vaildAnchor = anchor as? ARImageAnchor{
            
            let videoPlayerNode = SCNNode()
            var videoPlayer = AVPlayer()
                
            if let targetName = vaildAnchor.referenceImage.name, let validURL = Bundle.main.url(forResource: targetName, withExtension: "mp4", subdirectory: "/art.scnassets"){
                videoPlayer = (AVPlayer(url: validURL))
                videoPlayer.pause()
            }
                
            let videoPlayerGeometry = SCNPlane(width: vaildAnchor.referenceImage.physicalSize.width, height: vaildAnchor.referenceImage.physicalSize.height)
                
            videoPlayerGeometry.firstMaterial?.diffuse.contents = videoPlayer
            videoPlayerNode.geometry = videoPlayerGeometry
            videoPlayerNode.eulerAngles.x = -.pi / 2
            node.addChildNode(videoPlayerNode)
                
            let vc = videoContainer(targetName: vaildAnchor.referenceImage.name ?? "error", player: videoPlayer, node: videoPlayerNode, anchor: anchor, play: false)
            videoContainers.append(vc)

        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        
        if let vaildAnchor = anchor as? ARImageAnchor{
            
            for vc in videoContainers{
                if vc.targetName == vaildAnchor.referenceImage.name {
                    if (CMTimeGetSeconds(vc.player.currentTime()) >=
                        CMTimeGetSeconds(vc.player.currentItem!.duration)) {
                        vc.player.seek(to: CMTime(seconds: 0, preferredTimescale: 60000) )
                    }
                    else if(!node.isHidden && vc.play) {
                        vc.player.play()
                        //remove playbutton
                        vc.node?.geometry?.firstMaterial?.emission.contents = false
                    }
                    else{
                        vc.player.pause()
                        //playbutton display
                        vc.node?.geometry?.firstMaterial?.emission.contents = UIImage(named: "playButton")
                    }
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let currentTouchLocation = touches.first?.location(in: self.sceneView) else {return}
        let hitTestResultNode = self.sceneView.hitTest(currentTouchLocation, options: nil)
     
        for result in hitTestResultNode{
            for vc in videoContainers{
                if result.node === vc.node{
                    if !(vc.player.rate > 0){
                        for vc in videoContainers{
                            vc.player.pause()
                            vc.play = false
                            //playbutton display
                            vc.node?.geometry?.firstMaterial?.emission.contents = UIImage(named: "playButton")
                        }
                        vc.player.play()
                        vc.play = true
                        //remove playbutton
                        vc.node?.geometry?.firstMaterial?.emission.contents = false
                        let tracker = GAI.sharedInstance().defaultTracker
                        tracker?.set(kGAIEvent, value: "ARvideo")
                        tracker?.send(GAIDictionaryBuilder.createEvent(withCategory: vc.targetName, action: vc.targetName, label: "testOne" , value: 1).build() as [NSObject : AnyObject])
                    }else{
                        vc.player.pause()
                        vc.play = false
                        //playbutton display
                        vc.node?.geometry?.firstMaterial?.emission.contents = UIImage(named: "playButton")
                    }
                }
            }
        }
     }
    
}

