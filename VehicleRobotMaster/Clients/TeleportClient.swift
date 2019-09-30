//
// Created by 李翌文 on 2019/9/17.
// Copyright (c) 2019 Johnnyeven. All rights reserved.
//

import Foundation
import Socket
import BinarySwift

enum MessageType: Int32 {
    case typeUnknown = 0
    case typeCall = 1
    case typeReply = 2
    case typePush = 3
    case typeAuthCall = 4
    case typeAuthReply = 5
}

class TeleportClient {

    private var remainData: Data?
    private static var instance: TeleportClient?
    private var sequence: Int32 = 0
    private var client: Socket?
    private var replyHandlerMap: Dictionary<Int32, (Data) -> Void> = Dictionary<Int32, (Data) -> Void>()
    private var requestHandlerMap: Dictionary<String, (Data) -> Void> = Dictionary<String, (Data) -> Void>()

    static func getInstance() -> TeleportClient? {
        if (instance == nil) {
            instance = TeleportClient()
        }
        return instance
    }

    init() {
        do {
            client = try Socket.create()
            try client?.connect(to: "robot.profzone.net", port: 9090)
        } catch let error {
            return
        }

        DispatchQueue.global(qos: .background).async(execute: {
            func readPayload() throws -> Data? {
                var payload = Data()
                var allPayload = Data()
                let length = try self.client?.read(into: &payload)
                if length == 0 && self.remainData == nil {
                    return nil
                }
                
                if self.remainData != nil {
                    allPayload.append(self.remainData!)
                    self.remainData = nil
                }
                if length! > 0 {
                    allPayload.append(payload)
                }
                return allPayload
            }

            while true {
                do {
                    let payload = try readPayload()
                    if payload == nil {
                        continue
                    }
                    let payloadData = BinaryData(data: payload!)
                    let payloadReader = BinaryDataReader(payloadData)
                    var payloadDataLength = payloadData.data.count
                    let messageLength: UInt32 = try payloadReader.read(true)
                    let max = UINT16_MAX
                    if messageLength > max {
                        continue
                    }
                    if messageLength + 4 > payloadDataLength {
                        self.remainData = payload
                        continue
                    }
                    
                    let xferPipeLength: UInt8 = try payloadReader.read(true)
                    if xferPipeLength > 0 {
                        let xferPipeData: BinaryData = try payloadReader.read(Int(xferPipeLength))
                    }
                    
                    let remainLength: Int = Int(messageLength) - Int(xferPipeLength) - 1
                    let messageData: BinaryData = try payloadReader.read(remainLength)
                    let message = try Pb.Payload.parseFrom(data: Data(buffer: UnsafeBufferPointer(start: messageData.data, count: remainLength)))
                    DispatchQueue.main.async(execute: {
                        do {
                            try self.processMessage(message: message)
                        } catch let error {
                            log.error(error.localizedDescription)
                        }
                    })
                    let remainData: BinaryData = try payloadReader.readNextAll()
                    self.remainData = Data(buffer: UnsafeBufferPointer(start: remainData.data, count: remainData.data.count))
                    
                } catch {
                    log.error(error)
                    self.remainData = nil
                }
            }
        })
    }

    private func call(method: String, body: Encodable, bodyCodec: Character, closure: @escaping (Data) -> Void) throws {
        try send(type: MessageType.typeCall, method: method, body: body, bodyCodec: bodyCodec)
        replyHandlerMap.updateValue(closure, forKey: sequence)
    }
    
    private func push(method: String, body: Encodable, bodyCodec: Character) throws {
        try send(type: MessageType.typePush, method: method, body: body, bodyCodec: bodyCodec)
    }
    
    private func send(type: MessageType, method: String, body: Encodable, bodyCodec: Character) throws {
        sequence += 1
        let message = Pb.Payload.Builder()
        message.setSeq(sequence)
        message.setMtype(type.rawValue)
        message.setServiceMethod(method)
        message.setStatus(Status().encodeQuery())
        message.setBodyCodec(Int32(bodyCodec.asciiValue!))

        let bodyEncoded = try serializeBody(model: body)
        message.setBody(bodyEncoded)

        let payload = try message.build()
        let payloadData = payload.data()
        var data = Data()

        let messageLength: UInt32 = UInt32(payloadData.count) + 1
        data.append(withUnsafeBytes(of: messageLength.bigEndian, { Data($0) }))
        let xperPipLength: UInt8 = 0
        data.append(withUnsafeBytes(of: xperPipLength.bigEndian, { Data($0) }))
        data.append(payloadData)

        try client?.write(from: data)
    }

    private func serializeBody(model: Encodable) throws -> Data {
        let encode = AnyEncodable(value: model)
        return try JSONEncoder().encode(encode)
    }

    private func processMessage(message: Pb.Payload) throws {
        if message.mtype == MessageType.typeReply.rawValue {
            let sequence = message.seq
            let closure = replyHandlerMap[sequence!]
            if closure != nil {
                (closure!)(message.body!)
            }
        } else {
            let handler = requestHandlerMap[message.serviceMethod]
            if handler != nil {
                (handler!)(message.body!)
            }
        }
    }

    func authorization(req: AuthorizationRequest, closure: @escaping (Data) -> Void) -> Status? {
        do {
            try self.call(method: "/authorization/auth", body: req, bodyCodec: "j", closure: closure)
        } catch let error {
            return Status(code: 10, message: "", cause: error.localizedDescription)
        }

        return nil
    }

    func getNodes(req: GetNodesRequest, closure: @escaping (Data) -> Void) -> Status? {
        do {
            try self.call(method: "/nodes/robot", body: req, bodyCodec: "j", closure: closure)
        } catch let error {
            return Status(code: 10, message: "", cause: error.localizedDescription)
        }
        
        return nil
    }
    
    func powerMoving(req: PowerMovingRequest) -> Status? {
        do {
            try push(method: "/power/moving", body: req, bodyCodec: "j")
        } catch {
            return Status(code: 10, message: "", cause: error.localizedDescription)
        }
        
        return nil
    }
    
    func cameraHolder(req: CameraHolderRequest) -> Status? {
        do {
            try push(method: "/camera/holder", body: req, bodyCodec: "j")
        } catch {
            return Status(code: 10, message: "", cause: error.localizedDescription)
        }
        
        return nil
    }
    
    func pushRouter(method: String, handler: @escaping (Data) -> Void) {
        requestHandlerMap.updateValue(handler, forKey: method)
    }
}
