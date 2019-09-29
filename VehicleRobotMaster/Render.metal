//
//  Render.metal
//  VehicleRobotMaster
//
//  Created by 李翌文 on 2019/9/23.
//  Copyright © 2019 Johnnyeven. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

struct VertexIn {
    float4 position;
    float2 textureCoordinate;
};

struct VertexOut {
    float4 position [[ position ]];
    float2 textureCoordinate;
};

vertex VertexOut basic_vertex(const device VertexIn *vertices [[ buffer(0) ]], uint vertexID [[ vertex_id ]]) {
    VertexOut vOut;
    vOut.position = vertices[vertexID].position;
    vOut.textureCoordinate = vertices[vertexID].textureCoordinate;
    return vOut;
}

fragment half4 basic_fragment(VertexOut vIn [[ stage_in ]], texture2d<half> colorTexture [[ texture(0) ]]) {
    constexpr sampler textureSampler(mag_filter::linear, min_filter::linear); // sampler是采样器
    return colorTexture.sample(textureSampler, vIn.textureCoordinate); // 得到纹理对应位置的颜色
}
