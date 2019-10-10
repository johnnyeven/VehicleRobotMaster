//
// Created by 李翌文 on 2019/9/18.
// Copyright (c) 2019 Johnnyeven. All rights reserved.
//

import Foundation

enum MovingDirection: String, Encodable {
    case Forward = "FORWARD"
    case Backward = "BACKWARD"
    case TurnLeft = "TURN_LEFT"
    case TurnRight = "TURN_RIGHT"
    case Stop = "STOP"
}

enum HolderDerection: String, Encodable {
    case Horizen = "HORIZEN"
    case Vertical = "VERTICAL"
}

struct BroadcastRequest: Decodable {
    var port: UInt16
}

struct AuthorizationRequest: Encodable {
    var key: String
}

struct AuthorizationResponse: Decodable {
    var token: String
}

struct GetNodesRequest: Encodable {
    var token: String
}

struct GetNodesResponse: Decodable {
    var nodes: [GetNodesResponseItem]
}

struct GetNodesResponseItem: Decodable {
    var key: String
    var secret: String
    var comment: String
    var nodeType: String
    var token: String
}

struct CameraTransferResponse: Decodable {
    var token: String
    var frame: Data
}

struct PowerMovingRequest: Encodable {
    var token: String
    var target: String
    var direction: MovingDirection
    var speed: Float64
}

struct CameraHolderRequest: Encodable {
    var token: String
    var target: String
    var horizonOffset: Float64
    var verticalOffset: Float64
}
