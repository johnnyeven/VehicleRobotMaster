//
//  CameraView.swift
//  VehicleRobotMaster
//
//  Created by 李翌文 on 2019/9/23.
//  Copyright © 2019 Johnnyeven. All rights reserved.
//

import Foundation
import MetalKit

class CameraView: MTKView {
    var renderer: Renderer!
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        #if !os(macOS) && !targetEnvironment(simulator)
        guard let defaultDevice = MTLCreateSystemDefaultDevice() else {
            fatalError("Device loading error")
        }
        device = defaultDevice
        colorPixelFormat = .bgra8Unorm
        clearColor = MTLClearColor(red: 0, green: 0, blue: 0, alpha: 0)
        
        createRenderer(device: defaultDevice)
        #endif
    }
    
    private func createRenderer(device: MTLDevice) {
        renderer = Renderer(device: device)
        delegate = renderer
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touch began")
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touch move")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touch end")
    }
}
