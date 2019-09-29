//
//  Renderer.swift
//  VehicleRobotMaster
//
//  Created by 李翌文 on 2019/9/23.
//  Copyright © 2019 Johnnyeven. All rights reserved.
//

import MetalKit

struct Vertex {
    var position: simd_float4
    var texturePosition: simd_float2
}

class Renderer: NSObject {
    var device: MTLDevice!
    var view: MTKView!
    var commandQueue: MTLCommandQueue!
    var renderPipelineState: MTLRenderPipelineState!
    var vertexBuffer: MTLBuffer!
    var vertices: [Vertex] = []
    var textureLoader: MTKTextureLoader!
    var texture: MTLTexture!
    
    init(device: MTLDevice) {
        super.init()
        
        self.device = device
        createPipelineState(device: device)
        createCommandQueue(device: device)
        
        TeleportClient.getInstance()?.pushRouter(method: "/camera/transfer", handler: self.handleCameraTransfer)
    }
    
    private func createPipelineState(device: MTLDevice) {
        let library = device.makeDefaultLibrary()
        let vertexFunction = library?.makeFunction(name: "basic_vertex")
        let fragmentFunction = library?.makeFunction(name: "basic_fragment")
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        renderPipelineDescriptor.vertexFunction = vertexFunction
        renderPipelineDescriptor.fragmentFunction = fragmentFunction
        do {
            renderPipelineState = try device.makeRenderPipelineState(descriptor: renderPipelineDescriptor)
        } catch {
            log.error(error)
        }
        textureLoader = MTKTextureLoader(device: device)
    }
    
    private func createCommandQueue(device: MTLDevice) {
        commandQueue = device.makeCommandQueue()
    }
    
    private func createBuffer(device: MTLDevice) {
        vertexBuffer = device.makeBuffer(bytes: vertices, length: MemoryLayout<Vertex>.stride * vertices.count, options: [])
    }
    
    private func handleCameraTransfer(data: Data) {
        do {
            let resp = try JSONDecoder().decode(CameraTransferResponse.self, from: data)
            texture = try textureLoader.newTexture(data: resp.frame)
            
            if vertices.count == 0 {
                let viewRectRate = view.bounds.width / view.bounds.height
                let frameRectRate = CGFloat(texture.width) / CGFloat(texture.height)
                var baseWidth: Float = 1.0
                var baseHeight: Float = 1.0
                if viewRectRate > frameRectRate {
                    baseWidth = Float(CGFloat(texture.width) / (CGFloat(texture.height) / view.bounds.height * view.bounds.width))
                } else {
                    baseHeight = Float(CGFloat(texture.height) / (CGFloat(texture.width) / view.bounds.width * view.bounds.height))
                }
                
                vertices.append(Vertex(position: simd_float4(baseWidth, -baseHeight, 0, 1), texturePosition: simd_float2(1, 1)))
                vertices.append(Vertex(position: simd_float4(-baseWidth, -baseHeight, 0, 1), texturePosition: simd_float2(0, 1)))
                vertices.append(Vertex(position: simd_float4(-baseWidth, baseHeight, 0, 1), texturePosition: simd_float2(0, 0)))
                
                vertices.append(Vertex(position: simd_float4(baseWidth, -baseHeight, 0, 1), texturePosition: simd_float2(1, 1)))
                vertices.append(Vertex(position: simd_float4(-baseWidth, baseHeight, 0, 1), texturePosition: simd_float2(0, 0)))
                vertices.append(Vertex(position: simd_float4(baseWidth, baseHeight, 0, 1), texturePosition: simd_float2(1, 0)))
                createBuffer(device: self.device)
            }
        } catch {
            log.error(error)
        }
    }
}

extension Renderer: MTKViewDelegate {
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        self.view = view
    }
    
    func draw(in view: MTKView) {
        if self.texture == nil { return }
        guard let drawable = view.currentDrawable, let renderPassDescriptor = view.currentRenderPassDescriptor else { return }
        let commandBuffer = commandQueue.makeCommandBuffer()
        
        let commandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        commandEncoder?.setRenderPipelineState(renderPipelineState)
        commandEncoder?.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        commandEncoder?.setFragmentTexture(texture, index: 0)
        commandEncoder?.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertices.count)
        commandEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
    
}
