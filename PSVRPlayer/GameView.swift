//
//  PSVRView.swift
//  PSVR
//
//  Created by Zakk Hoyt on 10/25/16.
//  Copyright (c) 2016 Zakk Hoyt. All rights reserved.
//

import SceneKit
import ModelIO

class PSVRView: SCNView {
    
    fileprivate var cardboardNode: SCNNode!
    
    
    override func awakeFromNib(){
        super.awakeFromNib()
        setupScene()
    }
    
    private func setupScene() {
    
        let scene = SCNScene()
        
        // create and add a light to the scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        scene.rootNode.addChildNode(lightNode)
        
        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = NSColor.darkGray
        scene.rootNode.addChildNode(ambientLightNode)
        
        
        
        //let cardboardScene = SCNScene(named: "art.scnassets/cardboard.dae")!
        //        let cardboardScene = SCNScene(named: "art.scnassets/PS_VR.dae")!
        let cardboardScene = SCNScene(named: "art.scnassets/dualshock.dae")!
        self.cardboardNode = SCNNode()
        for childNode in cardboardScene.rootNode.childNodes {
            cardboardNode.addChildNode(childNode as SCNNode)
        }
        
        

//        let path = Bundle.main.path(forResource: "PS_VR", ofType: "obj")
//        let url = URL(fileURLWithPath: path!)
//        let asset = MDLAsset(url: url)
////        let cardboardScene = SCNScene(md)
//        self.cardboardNode = SCNNode()
//        for childNode in cardboardScene.rootNode.childNodes {
//            cardboardNode.addChildNode(childNode as SCNNode)
//        }
        
        
        
        
        scene.rootNode.addChildNode(cardboardNode)
        
        
        // set the scene to the view
        self.scene = scene
        
        // allows the user to manipulate the camera
        self.allowsCameraControl = true
        
        // show statistics such as fps and timing information
        self.showsStatistics = true
        
        // configure the view
        self.backgroundColor = NSColor.clear
    }
    
    override func mouseDown(with theEvent: NSEvent) {
        /* Called when a mouse click occurs */
        
        // check what nodes are clicked
        let p = self.convert(theEvent.locationInWindow, from: nil)
        let hitResults = self.hitTest(p, options: [:])
        // check that we clicked on at least one object
        if hitResults.count > 0 {
            // retrieved the first clicked object
            let result: AnyObject = hitResults[0]
            
            // get its material
            let material = result.node!.geometry!.firstMaterial!
            
            // highlight it
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.5
            
            // on completion - unhighlight
            SCNTransaction.completionBlock = {
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 0.5
                
                material.emission.contents = NSColor.black
                
                SCNTransaction.commit()
            }
            
            material.emission.contents = NSColor(red: 0.3, green: 0.8, blue: 1.0, alpha: 1.0)
            
            SCNTransaction.commit()
        }
        
        super.mouseDown(with: theEvent)
    }
    
    func update(rotation: SCNVector4) {
        Swift.print("\(rotation)")
     //   let rotate = SCNAction.rotate(toAxisAngle: rotation, duration: 0.1)
        let rotate = SCNAction.rotateTo(x: rotation.x, y: rotation.y, z: rotation.z, duration: 0.1)
        cardboardNode.runAction(rotate)
    }
    
    // MARK: Public methods
    
    func set(roll: CGFloat) {
        var rotation = cardboardNode.rotation
        rotation.z = roll
        update(rotation: rotation)
    }
    
    func set(pitch: CGFloat) {
        var rotation = cardboardNode.rotation
        rotation.x = pitch
        update(rotation: rotation)
    }
    
    func set(yaw: CGFloat) {
        var rotation = cardboardNode.rotation
        rotation.y = yaw
        update(rotation: rotation)
    }

}
