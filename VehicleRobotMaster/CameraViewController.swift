//
//  CameraViewController.swift
//  VehicleRobotMaster
//
//  Created by 李翌文 on 2019/9/23.
//  Copyright © 2019 Johnnyeven. All rights reserved.
//

import UIKit
import Metal
import QuartzCore
import CDJoystick

@available(iOS 13.0, *)
class CameraViewController: UIViewController {
    
    @IBOutlet weak var joystick: CDJoystick!
    
    private var prevDirection: MovingDirection = MovingDirection.Stop
    private var prevSpeed: Float64 = 0
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        appDelegate.interfaceOrientations = [.landscapeRight, .landscapeLeft]
        
        super.viewDidLoad()
        
        joystick.trackingHandler = self.handleJoystick
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
         
        appDelegate.interfaceOrientations = .portrait
    }
    
    private func handleJoystick(data: CDJoystickData) {
        var direction: MovingDirection
        let speed: Float64 = Float64(hypotf(Float(data.velocity.x), Float(data.velocity.y)))
        var angle = data.angle * 180 / CGFloat(Double.pi) + 45
        if angle >= 360 {
            angle -= 360
        }
        
        if angle >= 0 && angle < 90 {
            // forward
            direction = MovingDirection.Forward
        } else if angle < 180 {
            // right
            direction = MovingDirection.TurnRight
        } else if angle < 270 {
            // backward
            direction = MovingDirection.Backward
        } else {
            // left
            direction = MovingDirection.TurnLeft
        }
        
        if speed == 0 {
            direction = MovingDirection.Stop
        }
        
        if direction != prevDirection || speed != prevSpeed {
            prevDirection = direction
            prevSpeed = speed
            let request = PowerMovingRequest(token: token, target: controlTarget, direction: direction, speed: speed)
            _ = TeleportClient.getInstance()?.powerMoving(req: request)
        }
    }

}
