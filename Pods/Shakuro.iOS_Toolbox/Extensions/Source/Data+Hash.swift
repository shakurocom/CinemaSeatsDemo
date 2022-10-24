//
// Copyright (c) 2019 Shakuro (https://shakuro.com/)
// Sergey Laschuk; original found on the Internets
//

import CommonCryptoModule
import Foundation

extension Data {

    public func SHA512() -> String? {
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA512_DIGEST_LENGTH))
        self.withUnsafeBytes { (unsafeBytes: UnsafeRawBufferPointer) -> Void in
            CC_SHA512(unsafeBytes.baseAddress, CC_LONG(self.count), &digest)
        }
        let output: String = digest.reduce(into: "", { (result: inout String, byte) in
            result += String(format: "%02x", byte)
        })
        return output
    }

    public func MD5() -> String? {
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        self.withUnsafeBytes { (unsafeBytes: UnsafeRawBufferPointer) -> Void in
            CC_MD5(unsafeBytes.baseAddress, CC_LONG(self.count), &digest)
        }
        let output: String = digest.reduce(into: "", { (result: inout String, byte) in
            result += String(format: "%02x", byte)
        })
        return output
    }

}
