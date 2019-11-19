//
//  INVSCrypto.swift
//  InvestScopio
//
//  Created by Joao Medeiros Pereira on 18/06/19.
//  Copyright © 2019 Joao Medeiros Pereira. All rights reserved.
//

import Foundation
import CryptoSwift

class INVSCrypto: NSObject {
    static let aesKey = "investscopiosect"
    static let aesIV = "sectscopioinvest"
    static let sha256Key = "com.br.joao.gabriel.medeiros.pereira.InvestScopio"
    static func encryptAES(withText text:String) -> String? {
        do {
            let aes = try AES(key: aesKey, iv: aesIV) // aes128
            let crypto = try aes.encrypt(Array(text.utf8))
            return crypto.toHexString()
        } catch {
            print("Encrypt Error")
            return nil
        }
    }
    
    static func decryptAES(withText text:String) -> String? {
        if let bytes = stringToBytes(text) {
            do {
                let aes = try AES(key: aesKey, iv: aesIV) // aes128
                let decrypto = try aes.decrypt(bytes)
                let decryptedString = String(bytes: decrypto, encoding: .utf8)
                return decryptedString
            } catch {
                print("Decrypt Error")
                return nil
            }
        }
        return nil
    }
    
    static func stringToBytes(_ string: String) -> [UInt8]? {
        let length = string.count
        if length & 1 != 0 {
            return nil
        }
        var bytes = [UInt8]()
        bytes.reserveCapacity(length/2)
        var index = string.startIndex
        for _ in 0..<length/2 {
            let nextIndex = string.index(index, offsetBy: 2)
            if let b = UInt8(string[index..<nextIndex], radix: 16) {
                bytes.append(b)
            } else {
                return nil
            }
            index = nextIndex
        }
        return bytes
    }

}
