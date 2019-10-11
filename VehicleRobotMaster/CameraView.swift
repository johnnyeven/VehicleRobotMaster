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
    var startX: CGFloat = 0
    var startY: CGFloat = 0
    
    
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
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        startX = location.x
        startY = location.y
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        let offsetX = location.x - startX
        let offsetY = location.y - startY
        
        startX = location.x
        startY = location.y
        
        let request = CameraHolderRequest(token: token, target: controlTarget, horizonOffset: Float64(offsetX) * 0.2, verticalOffset: Float64(offsetY) * 0.2)
        _ = TeleportClient.getInstance()?.cameraHolder(req: request) {data in}
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        startX = 0
        startY = 0
    }
}
