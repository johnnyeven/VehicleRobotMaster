//
// Created by 李翌文 on 2019/9/18.
// Copyright (c) 2019 Johnnyeven. All rights reserved.
//

import Foundation

enum StatusCode: Int32 {
    case ok = 0
    case unknownError = -1
}

class Status: Codable {
    var code: Int32 = 0
    var message: String = ""
    var cause: String = ""

    init() {
    }

    init(code: Int32, message: String, cause: String) {
        self.code = code
        self.message = message
        self.cause = cause
    }

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case message = "msg"
        case cause = "cause"
    }

    static func fromJson(from: Data) throws -> Status? {
        let decoder = JSONDecoder()
        return try decoder.decode(Status.self, from: from)
    }

    func clear() {
        self.code = 0
        self.message = ""
        self.cause = ""
    }

    func isOk() -> Bool {
        return self.code == StatusCode.ok.rawValue
    }

    func isUnknownError() -> Bool {
        return self.code == StatusCode.unknownError.rawValue
    }

    func encodeQuery() -> Data {
        var data = Data()
        data.append(CodingKeys.code.rawValue.data(using: .utf8)!)
        data.append("=".data(using: .utf8)!)
        data.append(String(self.code).data(using: .utf8)!)
        if self.message.count > 0 {
            data.append("&".data(using: .utf8)!)
            data.append(CodingKeys.message.rawValue.data(using: .utf8)!)
            data.append("=".data(using: .utf8)!)
            data.append(self.message.data(using: .utf8)!)
        }
        if self.cause.count > 0 {
            data.append("&".data(using: .utf8)!)
            data.append(CodingKeys.cause.rawValue.data(using: .utf8)!)
            data.append("=".data(using: .utf8)!)
            data.append(self.cause.data(using: .utf8)!)
        }

        return data
    }

    func decodeQuery(from: Data) {
        self.clear()
        if from.count == 0 {
            return
        }

        let raw = String(decoding: from, as: UTF8.self)
        let kvs = raw.components(separatedBy: "&")

        for kv in kvs {
            let pair = kv.components(separatedBy: "=")
            switch pair[0] {
            case CodingKeys.code.rawValue:
                self.code = Int32(pair[1])!
            case CodingKeys.message.rawValue, CodingKeys.cause.rawValue:
                self.message = pair[1]
            default:
                break
            }
        }
    }
}
