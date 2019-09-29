//
// Created by 李翌文 on 2019/9/18.
// Copyright (c) 2019 Johnnyeven. All rights reserved.
//

import Foundation

struct AnyEncodable: Encodable {
    let value: Encodable

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try value.encode(to: &container)
    }

    init(value: Encodable) {
        self.value = value
    }
}

extension Encodable {
    func encode(to container: inout SingleValueEncodingContainer) throws {
        try container.encode(self)
    }
}