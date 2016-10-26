//
//  PSVRViewController.swift
//  PSVRPlayer
//
//  Created by Zakk Hoyt on 10/25/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import Cocoa
import SceneKit
import QuartzCore


class PSVRViewController: NSViewController {

    
    fileprivate var cardboardNode: SCNNode!
    
    @IBOutlet weak var psvrView: PSVRView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func rollSliderAction(_ sender: NSSlider) {
        let roll = CGFloat(sender.floatValue / 100.0)
        print("roll: \(roll)")
        psvrView.set(roll: roll)
    }
    @IBAction func pitchSliderAction(_ sender: NSSlider) {
        let pitch = CGFloat(sender.floatValue / 100.0)
        print("roll: \(pitch)")
        psvrView.set(pitch: pitch)

    }

    @IBAction func yawSliderAction(_ sender: NSSlider) {
        let yaw = CGFloat(sender.floatValue / 100.0)
        print("yaw: \(yaw)")
        psvrView.set(pitch: yaw)
    }

    


    

}

