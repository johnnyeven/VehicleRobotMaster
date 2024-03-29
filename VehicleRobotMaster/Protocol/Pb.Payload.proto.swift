/// Generated by the Protocol Buffers 3.7.1 compiler.  DO NOT EDIT!
/// Protobuf-swift version: 4.0.0
/// Source file "payload.proto"
/// Syntax "Proto3"

import Foundation
import ProtocolBuffers


public struct Pb { }

public extension Pb {
    public struct PayloadRoot {
        public static let `default` = PayloadRoot()
        public var extensionRegistry:ExtensionRegistry

        init() {
            extensionRegistry = ExtensionRegistry()
            registerAllExtensions(registry: extensionRegistry)
        }
        public func registerAllExtensions(registry: ExtensionRegistry) {
        }
    }

    final public class Payload : GeneratedMessage {
        public typealias BuilderType = Pb.Payload.Builder

        public static func == (lhs: Pb.Payload, rhs: Pb.Payload) -> Bool {
            if lhs === rhs {
                return true
            }
            var fieldCheck:Bool = (lhs.hashValue == rhs.hashValue)
            fieldCheck = fieldCheck && (lhs.hasSeq == rhs.hasSeq) && (!lhs.hasSeq || lhs.seq == rhs.seq)
            fieldCheck = fieldCheck && (lhs.hasMtype == rhs.hasMtype) && (!lhs.hasMtype || lhs.mtype == rhs.mtype)
            fieldCheck = fieldCheck && (lhs.hasServiceMethod == rhs.hasServiceMethod) && (!lhs.hasServiceMethod || lhs.serviceMethod == rhs.serviceMethod)
            fieldCheck = fieldCheck && (lhs.hasStatus == rhs.hasStatus) && (!lhs.hasStatus || lhs.status == rhs.status)
            fieldCheck = fieldCheck && (lhs.hasMeta == rhs.hasMeta) && (!lhs.hasMeta || lhs.meta == rhs.meta)
            fieldCheck = fieldCheck && (lhs.hasBodyCodec == rhs.hasBodyCodec) && (!lhs.hasBodyCodec || lhs.bodyCodec == rhs.bodyCodec)
            fieldCheck = fieldCheck && (lhs.hasBody == rhs.hasBody) && (!lhs.hasBody || lhs.body == rhs.body)
            fieldCheck = (fieldCheck && (lhs.unknownFields == rhs.unknownFields))
            return fieldCheck
        }

        public fileprivate(set) var seq:Int32! = nil
        public fileprivate(set) var hasSeq:Bool = false

        public fileprivate(set) var mtype:Int32! = nil
        public fileprivate(set) var hasMtype:Bool = false

        public fileprivate(set) var serviceMethod:String! = nil
        public fileprivate(set) var hasServiceMethod:Bool = false

        public fileprivate(set) var status:Data! = nil
        public fileprivate(set) var hasStatus:Bool = false

        public fileprivate(set) var meta:Data! = nil
        public fileprivate(set) var hasMeta:Bool = false

        public fileprivate(set) var bodyCodec:Int32! = nil
        public fileprivate(set) var hasBodyCodec:Bool = false

        public fileprivate(set) var body:Data! = nil
        public fileprivate(set) var hasBody:Bool = false

        required public init() {
            super.init()
        }
        override public func isInitialized() throws {
        }
        override public func writeTo(codedOutputStream: CodedOutputStream) throws {
            if hasSeq {
                try codedOutputStream.writeInt32(fieldNumber: 1, value:seq)
            }
            if hasMtype {
                try codedOutputStream.writeInt32(fieldNumber: 2, value:mtype)
            }
            if hasServiceMethod {
                try codedOutputStream.writeString(fieldNumber: 3, value:serviceMethod)
            }
            if hasStatus {
                try codedOutputStream.writeData(fieldNumber: 4, value:status)
            }
            if hasMeta {
                try codedOutputStream.writeData(fieldNumber: 5, value:meta)
            }
            if hasBodyCodec {
                try codedOutputStream.writeInt32(fieldNumber: 6, value:bodyCodec)
            }
            if hasBody {
                try codedOutputStream.writeData(fieldNumber: 7, value:body)
            }
            try unknownFields.writeTo(codedOutputStream: codedOutputStream)
        }
        override public func serializedSize() -> Int32 {
            var serialize_size:Int32 = memoizedSerializedSize
            if serialize_size != -1 {
             return serialize_size
            }

            serialize_size = 0
            if hasSeq {
                serialize_size += seq.computeInt32Size(fieldNumber: 1)
            }
            if hasMtype {
                serialize_size += mtype.computeInt32Size(fieldNumber: 2)
            }
            if hasServiceMethod {
                serialize_size += serviceMethod.computeStringSize(fieldNumber: 3)
            }
            if hasStatus {
                serialize_size += status.computeDataSize(fieldNumber: 4)
            }
            if hasMeta {
                serialize_size += meta.computeDataSize(fieldNumber: 5)
            }
            if hasBodyCodec {
                serialize_size += bodyCodec.computeInt32Size(fieldNumber: 6)
            }
            if hasBody {
                serialize_size += body.computeDataSize(fieldNumber: 7)
            }
            serialize_size += unknownFields.serializedSize()
            memoizedSerializedSize = serialize_size
            return serialize_size
        }
        public class func getBuilder() -> Pb.Payload.Builder {
            return Pb.Payload.classBuilder() as! Pb.Payload.Builder
        }
        public func getBuilder() -> Pb.Payload.Builder {
            return classBuilder() as! Pb.Payload.Builder
        }
        override public class func classBuilder() -> ProtocolBuffersMessageBuilder {
            return Pb.Payload.Builder()
        }
        override public func classBuilder() -> ProtocolBuffersMessageBuilder {
            return Pb.Payload.Builder()
        }
        public func toBuilder() throws -> Pb.Payload.Builder {
            return try Pb.Payload.builderWithPrototype(prototype:self)
        }
        public class func builderWithPrototype(prototype:Pb.Payload) throws -> Pb.Payload.Builder {
            return try Pb.Payload.Builder().mergeFrom(other:prototype)
        }
        override public func encode() throws -> Dictionary<String,Any> {
            try isInitialized()
            var jsonMap:Dictionary<String,Any> = Dictionary<String,Any>()
            if hasSeq {
                jsonMap["seq"] = Int(seq)
            }
            if hasMtype {
                jsonMap["mtype"] = Int(mtype)
            }
            if hasServiceMethod {
                jsonMap["serviceMethod"] = serviceMethod
            }
            if hasStatus {
                jsonMap["status"] = status.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
            }
            if hasMeta {
                jsonMap["meta"] = meta.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
            }
            if hasBodyCodec {
                jsonMap["bodyCodec"] = Int(bodyCodec)
            }
            if hasBody {
                jsonMap["body"] = body.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
            }
            return jsonMap
        }
        override class public func decode(jsonMap:Dictionary<String,Any>) throws -> Pb.Payload {
            return try Pb.Payload.Builder.decodeToBuilder(jsonMap:jsonMap).build()
        }
        override class public func fromJSON(data:Data, options: JSONSerialization.ReadingOptions = []) throws -> Pb.Payload {
            return try Pb.Payload.Builder.fromJSONToBuilder(data:data, options:options).build()
        }
        override public func getDescription(indent:String) throws -> String {
            var output = ""
            if hasSeq {
                output += "\(indent) seq: \(String(describing: seq)) \n"
            }
            if hasMtype {
                output += "\(indent) mtype: \(String(describing: mtype)) \n"
            }
            if hasServiceMethod {
                output += "\(indent) serviceMethod: \(String(describing: serviceMethod)) \n"
            }
            if hasStatus {
                output += "\(indent) status: \(String(describing: status)) \n"
            }
            if hasMeta {
                output += "\(indent) meta: \(String(describing: meta)) \n"
            }
            if hasBodyCodec {
                output += "\(indent) bodyCodec: \(String(describing: bodyCodec)) \n"
            }
            if hasBody {
                output += "\(indent) body: \(String(describing: body)) \n"
            }
            output += unknownFields.getDescription(indent: indent)
            return output
        }
        override public var hashValue:Int {
            get {
                var hashCode:Int = 7
                if hasSeq {
                    hashCode = (hashCode &* 31) &+ seq.hashValue
                }
                if hasMtype {
                    hashCode = (hashCode &* 31) &+ mtype.hashValue
                }
                if hasServiceMethod {
                    hashCode = (hashCode &* 31) &+ serviceMethod.hashValue
                }
                if hasStatus {
                    hashCode = (hashCode &* 31) &+ status.hashValue
                }
                if hasMeta {
                    hashCode = (hashCode &* 31) &+ meta.hashValue
                }
                if hasBodyCodec {
                    hashCode = (hashCode &* 31) &+ bodyCodec.hashValue
                }
                if hasBody {
                    hashCode = (hashCode &* 31) &+ body.hashValue
                }
                hashCode = (hashCode &* 31) &+  unknownFields.hashValue
                return hashCode
            }
        }


        //Meta information declaration start

        override public class func className() -> String {
            return "Pb.Payload"
        }
        override public func className() -> String {
            return "Pb.Payload"
        }
        //Meta information declaration end

        final public class Builder : GeneratedMessageBuilder {
            fileprivate var builderResult:Pb.Payload = Pb.Payload()
            public func getMessage() -> Pb.Payload {
                return builderResult
            }

            required override public init () {
                super.init()
            }
            public var seq:Int32 {
                get {
                    return builderResult.seq
                }
                set (value) {
                    builderResult.hasSeq = true
                    builderResult.seq = value
                }
            }
            public var hasSeq:Bool {
                get {
                    return builderResult.hasSeq
                }
            }
            @discardableResult
            public func setSeq(_ value:Int32) -> Pb.Payload.Builder {
                self.seq = value
                return self
            }
            @discardableResult
            public func clearSeq() -> Pb.Payload.Builder{
                builderResult.hasSeq = false
                builderResult.seq = nil
                return self
            }
            public var mtype:Int32 {
                get {
                    return builderResult.mtype
                }
                set (value) {
                    builderResult.hasMtype = true
                    builderResult.mtype = value
                }
            }
            public var hasMtype:Bool {
                get {
                    return builderResult.hasMtype
                }
            }
            @discardableResult
            public func setMtype(_ value:Int32) -> Pb.Payload.Builder {
                self.mtype = value
                return self
            }
            @discardableResult
            public func clearMtype() -> Pb.Payload.Builder{
                builderResult.hasMtype = false
                builderResult.mtype = nil
                return self
            }
            public var serviceMethod:String {
                get {
                    return builderResult.serviceMethod
                }
                set (value) {
                    builderResult.hasServiceMethod = true
                    builderResult.serviceMethod = value
                }
            }
            public var hasServiceMethod:Bool {
                get {
                    return builderResult.hasServiceMethod
                }
            }
            @discardableResult
            public func setServiceMethod(_ value:String) -> Pb.Payload.Builder {
                self.serviceMethod = value
                return self
            }
            @discardableResult
            public func clearServiceMethod() -> Pb.Payload.Builder{
                builderResult.hasServiceMethod = false
                builderResult.serviceMethod = nil
                return self
            }
            public var status:Data {
                get {
                    return builderResult.status
                }
                set (value) {
                    builderResult.hasStatus = true
                    builderResult.status = value
                }
            }
            public var hasStatus:Bool {
                get {
                    return builderResult.hasStatus
                }
            }
            @discardableResult
            public func setStatus(_ value:Data) -> Pb.Payload.Builder {
                self.status = value
                return self
            }
            @discardableResult
            public func clearStatus() -> Pb.Payload.Builder{
                builderResult.hasStatus = false
                builderResult.status = nil
                return self
            }
            public var meta:Data {
                get {
                    return builderResult.meta
                }
                set (value) {
                    builderResult.hasMeta = true
                    builderResult.meta = value
                }
            }
            public var hasMeta:Bool {
                get {
                    return builderResult.hasMeta
                }
            }
            @discardableResult
            public func setMeta(_ value:Data) -> Pb.Payload.Builder {
                self.meta = value
                return self
            }
            @discardableResult
            public func clearMeta() -> Pb.Payload.Builder{
                builderResult.hasMeta = false
                builderResult.meta = nil
                return self
            }
            public var bodyCodec:Int32 {
                get {
                    return builderResult.bodyCodec
                }
                set (value) {
                    builderResult.hasBodyCodec = true
                    builderResult.bodyCodec = value
                }
            }
            public var hasBodyCodec:Bool {
                get {
                    return builderResult.hasBodyCodec
                }
            }
            @discardableResult
            public func setBodyCodec(_ value:Int32) -> Pb.Payload.Builder {
                self.bodyCodec = value
                return self
            }
            @discardableResult
            public func clearBodyCodec() -> Pb.Payload.Builder{
                builderResult.hasBodyCodec = false
                builderResult.bodyCodec = nil
                return self
            }
            public var body:Data {
                get {
                    return builderResult.body
                }
                set (value) {
                    builderResult.hasBody = true
                    builderResult.body = value
                }
            }
            public var hasBody:Bool {
                get {
                    return builderResult.hasBody
                }
            }
            @discardableResult
            public func setBody(_ value:Data) -> Pb.Payload.Builder {
                self.body = value
                return self
            }
            @discardableResult
            public func clearBody() -> Pb.Payload.Builder{
                builderResult.hasBody = false
                builderResult.body = nil
                return self
            }
            override public var internalGetResult:GeneratedMessage {
                get {
                    return builderResult
                }
            }
            @discardableResult
            override public func clear() -> Pb.Payload.Builder {
                builderResult = Pb.Payload()
                return self
            }
            override public func clone() throws -> Pb.Payload.Builder {
                return try Pb.Payload.builderWithPrototype(prototype:builderResult)
            }
            override public func build() throws -> Pb.Payload {
                try checkInitialized()
                return buildPartial()
            }
            public func buildPartial() -> Pb.Payload {
                let returnMe:Pb.Payload = builderResult
                return returnMe
            }
            @discardableResult
            public func mergeFrom(other:Pb.Payload) throws -> Pb.Payload.Builder {
                if other == Pb.Payload() {
                    return self
                }
                if other.hasSeq {
                    seq = other.seq
                }
                if other.hasMtype {
                    mtype = other.mtype
                }
                if other.hasServiceMethod {
                    serviceMethod = other.serviceMethod
                }
                if other.hasStatus {
                    status = other.status
                }
                if other.hasMeta {
                    meta = other.meta
                }
                if other.hasBodyCodec {
                    bodyCodec = other.bodyCodec
                }
                if other.hasBody {
                    body = other.body
                }
                try merge(unknownField: other.unknownFields)
                return self
            }
            @discardableResult
            override public func mergeFrom(codedInputStream: CodedInputStream) throws -> Pb.Payload.Builder {
                return try mergeFrom(codedInputStream: codedInputStream, extensionRegistry:ExtensionRegistry())
            }
            @discardableResult
            override public func mergeFrom(codedInputStream: CodedInputStream, extensionRegistry:ExtensionRegistry) throws -> Pb.Payload.Builder {
                let unknownFieldsBuilder:UnknownFieldSet.Builder = try UnknownFieldSet.builderWithUnknownFields(copyFrom:self.unknownFields)
                while (true) {
                    let protobufTag = try codedInputStream.readTag()
                    switch protobufTag {
                    case 0: 
                        self.unknownFields = try unknownFieldsBuilder.build()
                        return self

                    case 8:
                        seq = try codedInputStream.readInt32()

                    case 16:
                        mtype = try codedInputStream.readInt32()

                    case 26:
                        serviceMethod = try codedInputStream.readString()

                    case 34:
                        status = try codedInputStream.readData()

                    case 42:
                        meta = try codedInputStream.readData()

                    case 48:
                        bodyCodec = try codedInputStream.readInt32()

                    case 58:
                        body = try codedInputStream.readData()

                    default:
                        if (!(try parse(codedInputStream:codedInputStream, unknownFields:unknownFieldsBuilder, extensionRegistry:extensionRegistry, tag:protobufTag))) {
                            unknownFields = try unknownFieldsBuilder.build()
                            return self
                        }
                    }
                }
            }
            class override public func decodeToBuilder(jsonMap:Dictionary<String,Any>) throws -> Pb.Payload.Builder {
                let resultDecodedBuilder = Pb.Payload.Builder()
                if let jsonValueSeq = jsonMap["seq"] as? Int {
                    resultDecodedBuilder.seq = Int32(jsonValueSeq)
                } else if let jsonValueSeq = jsonMap["seq"] as? String {
                    resultDecodedBuilder.seq = Int32(jsonValueSeq)!
                }
                if let jsonValueMtype = jsonMap["mtype"] as? Int {
                    resultDecodedBuilder.mtype = Int32(jsonValueMtype)
                } else if let jsonValueMtype = jsonMap["mtype"] as? String {
                    resultDecodedBuilder.mtype = Int32(jsonValueMtype)!
                }
                if let jsonValueServiceMethod = jsonMap["serviceMethod"] as? String {
                    resultDecodedBuilder.serviceMethod = jsonValueServiceMethod
                }
                if let jsonValueStatus = jsonMap["status"] as? String {
                    resultDecodedBuilder.status = Data(base64Encoded:jsonValueStatus, options: Data.Base64DecodingOptions(rawValue:0))!
                }
                if let jsonValueMeta = jsonMap["meta"] as? String {
                    resultDecodedBuilder.meta = Data(base64Encoded:jsonValueMeta, options: Data.Base64DecodingOptions(rawValue:0))!
                }
                if let jsonValueBodyCodec = jsonMap["bodyCodec"] as? Int {
                    resultDecodedBuilder.bodyCodec = Int32(jsonValueBodyCodec)
                } else if let jsonValueBodyCodec = jsonMap["bodyCodec"] as? String {
                    resultDecodedBuilder.bodyCodec = Int32(jsonValueBodyCodec)!
                }
                if let jsonValueBody = jsonMap["body"] as? String {
                    resultDecodedBuilder.body = Data(base64Encoded:jsonValueBody, options: Data.Base64DecodingOptions(rawValue:0))!
                }
                return resultDecodedBuilder
            }
            override class public func fromJSONToBuilder(data:Data, options: JSONSerialization.ReadingOptions = []) throws -> Pb.Payload.Builder {
                let jsonData = try JSONSerialization.jsonObject(with:data, options: options)
                guard let jsDataCast = jsonData as? Dictionary<String,Any> else {
                  throw ProtocolBuffersError.invalidProtocolBuffer("Invalid JSON data")
                }
                return try Pb.Payload.Builder.decodeToBuilder(jsonMap:jsDataCast)
            }
        }

    }

}
extension Pb.Payload: GeneratedMessageProtocol {
    public class func parseArrayDelimitedFrom(inputStream: InputStream) throws -> Array<Pb.Payload> {
        var mergedArray = Array<Pb.Payload>()
        while let value = try parseDelimitedFrom(inputStream: inputStream) {
          mergedArray.append(value)
        }
        return mergedArray
    }
    public class func parseDelimitedFrom(inputStream: InputStream) throws -> Pb.Payload? {
        return try Pb.Payload.Builder().mergeDelimitedFrom(inputStream: inputStream)?.build()
    }
    public class func parseFrom(data: Data) throws -> Pb.Payload {
        return try Pb.Payload.Builder().mergeFrom(data: data, extensionRegistry:Pb.PayloadRoot.default.extensionRegistry).build()
    }
    public class func parseFrom(data: Data, extensionRegistry:ExtensionRegistry) throws -> Pb.Payload {
        return try Pb.Payload.Builder().mergeFrom(data: data, extensionRegistry:extensionRegistry).build()
    }
    public class func parseFrom(inputStream: InputStream) throws -> Pb.Payload {
        return try Pb.Payload.Builder().mergeFrom(inputStream: inputStream).build()
    }
    public class func parseFrom(inputStream: InputStream, extensionRegistry:ExtensionRegistry) throws -> Pb.Payload {
        return try Pb.Payload.Builder().mergeFrom(inputStream: inputStream, extensionRegistry:extensionRegistry).build()
    }
    public class func parseFrom(codedInputStream: CodedInputStream) throws -> Pb.Payload {
        return try Pb.Payload.Builder().mergeFrom(codedInputStream: codedInputStream).build()
    }
    public class func parseFrom(codedInputStream: CodedInputStream, extensionRegistry:ExtensionRegistry) throws -> Pb.Payload {
        return try Pb.Payload.Builder().mergeFrom(codedInputStream: codedInputStream, extensionRegistry:extensionRegistry).build()
    }
    public subscript(key: String) -> Any? {
        switch key {
        case "seq": return self.seq
        case "mtype": return self.mtype
        case "serviceMethod": return self.serviceMethod
        case "status": return self.status
        case "meta": return self.meta
        case "bodyCodec": return self.bodyCodec
        case "body": return self.body
        default: return nil
        }
    }
}
extension Pb.Payload.Builder: GeneratedMessageBuilderProtocol {
    public typealias GeneratedMessageType = Pb.Payload
    public subscript(key: String) -> Any? {
        get { 
            switch key {
            case "seq": return self.seq
            case "mtype": return self.mtype
            case "serviceMethod": return self.serviceMethod
            case "status": return self.status
            case "meta": return self.meta
            case "bodyCodec": return self.bodyCodec
            case "body": return self.body
            default: return nil
            }
        }
        set (newSubscriptValue) { 
            switch key {
            case "seq":
                guard let newSubscriptValue = newSubscriptValue as? Int32 else {
                    return
                }
                self.seq = newSubscriptValue
            case "mtype":
                guard let newSubscriptValue = newSubscriptValue as? Int32 else {
                    return
                }
                self.mtype = newSubscriptValue
            case "serviceMethod":
                guard let newSubscriptValue = newSubscriptValue as? String else {
                    return
                }
                self.serviceMethod = newSubscriptValue
            case "status":
                guard let newSubscriptValue = newSubscriptValue as? Data else {
                    return
                }
                self.status = newSubscriptValue
            case "meta":
                guard let newSubscriptValue = newSubscriptValue as? Data else {
                    return
                }
                self.meta = newSubscriptValue
            case "bodyCodec":
                guard let newSubscriptValue = newSubscriptValue as? Int32 else {
                    return
                }
                self.bodyCodec = newSubscriptValue
            case "body":
                guard let newSubscriptValue = newSubscriptValue as? Data else {
                    return
                }
                self.body = newSubscriptValue
            default: return
            }
        }
    }
}

// @@protoc_insertion_point(global_scope)
