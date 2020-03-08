//
//  AESCryto.swift
//  DailyRewards
//
//  Created by Joao Gabriel Pereira on 29/02/20.
//  Copyright © 2020 Joao Gabriel Medeiros Perei. All rights reserved.
//

import Foundation
import CommonCrypto

protocol Randomizer {
    static func randomIv() -> String
    static func randomSalt() -> String
    static func randomKey() -> String
}

protocol Crypter {
    func encrypt(_ digest: Data) -> String?
    func decrypt(_ encrypted: Data) throws -> Data
}

public struct JewAESCrypto: JSONAble {
    let AESKey: String
    let AESSalt: String
    let AESIV: String
    let deviceType: Int = 1 //iOS
                            //Android
    
}

public class AES256Crypter {
    static let standardChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890"
    private var key: Data = Data()
    private var iv: Data = Data()
    public static let crypto = AES256Crypter()
    public static func create() -> JewAESCrypto? {
        do {
        let salt = AES256Crypter.randomSalt()
        let iv = AES256Crypter.randomIv()
        let key = AES256Crypter.randomKey()
        let secretKey = try AES256Crypter.createKey(password: key.randomData(), salt: salt.randomData())
        let secretIv = iv.randomData()
        
        guard secretKey.count == kCCKeySizeAES256 else {
            JEWLogger.error(JewAESError.badKeyLength.localizedDescription)
            return nil
        }
        guard secretIv.count == kCCBlockSizeAES128 else {
            JEWLogger.error(JewAESError.badInputVectorLength.localizedDescription)
            return nil
        }
        AES256Crypter.crypto.key = secretKey
        AES256Crypter.crypto.iv = secretIv
        return JewAESCrypto(AESKey: key, AESSalt: salt, AESIV: iv)
        } catch let error {
            JEWLogger.error(error.localizedDescription)
            return nil
        }
    }
    
    enum JewAESError: Swift.Error {
        case keyGeneration(status: Int)
        case cryptoFailed(status: CCCryptorStatus)
        case badKeyLength
        case badInputVectorLength
    }
    
    private func crypt(input: Data, operation: CCOperation) throws -> Data {
        var outLength = Int(0)
        var outBytes = [UInt8](repeating: 0, count: input.count + kCCBlockSizeAES128)
        var status: CCCryptorStatus = CCCryptorStatus(kCCSuccess)
        input.withUnsafeBytes { (encryptedBytes: UnsafePointer<UInt8>!) -> () in
            iv.withUnsafeBytes { (ivBytes: UnsafePointer<UInt8>!) in
                key.withUnsafeBytes { (keyBytes: UnsafePointer<UInt8>!) -> () in
                    status = CCCrypt(operation,
                                     CCAlgorithm(kCCAlgorithmAES128),            // algorithm
                        CCOptions(kCCOptionPKCS7Padding),           // options
                        keyBytes,                                   // key
                        key.count,                                  // keylength
                        ivBytes,                                    // iv
                        encryptedBytes,                             // dataIn
                        input.count,                                // dataInLength
                        &outBytes,                                  // dataOut
                        outBytes.count,                             // dataOutAvailable
                        &outLength)                                 // dataOutMoved
                }
            }
        }
        guard status == kCCSuccess else {
            throw JewAESError.cryptoFailed(status: status)
        }
            
        return Data(bytes: UnsafePointer<UInt8>(outBytes), count: outLength)
    }
    
    static func createKey(password: Data, salt: Data) throws -> Data {
        let length = kCCKeySizeAES256
        var status = Int32(0)
        var derivedBytes = [UInt8](repeating: 0, count: length)
        password.withUnsafeBytes { (passwordBytes: UnsafePointer<Int8>!) in
            salt.withUnsafeBytes { (saltBytes: UnsafePointer<UInt8>!) in
                status = CCKeyDerivationPBKDF(CCPBKDFAlgorithm(kCCPBKDF2),                  // algorithm
                    passwordBytes,                                // password
                    password.count,                               // passwordLen
                    saltBytes,                                    // salt
                    salt.count,                                   // saltLen
                    CCPseudoRandomAlgorithm(kCCPRFHmacAlgSHA1),   // prf
                    1000,                                        // rounds
                    &derivedBytes,                                // derivedKey
                    length)                                       // derivedKeyLen
            }
        }
        guard status == 0 else {
            throw JewAESError.keyGeneration(status: Int(status))
        }
        let data = Data(bytes: UnsafePointer<UInt8>(derivedBytes), count: length)
        return data
    }
    
}

extension AES256Crypter: Crypter {
    
    public func encrypt(_ digest: Data) -> String? {
        do {
            let encryptedData = try crypt(input: digest, operation: CCOperation(kCCEncrypt))
            let text = encryptedData.base64EncodedString(options: [])
            return text
        } catch let error {
            JEWLogger.error(error.localizedDescription)
            return nil
        }
    }
    
    public func decrypt(_ encrypted: Data) throws -> Data {
        return try crypt(input: encrypted, operation: CCOperation(kCCDecrypt))
    }
    
}

extension AES256Crypter: Randomizer {
    
    static func randomIv() -> String {
        return randomString(count: kCCBlockSizeAES128)
    }
    
    static func randomSalt() -> String {
        return randomString(count: 8)
    }
    
    static func randomKey() -> String {
        return randomString(count: 16)
    }
    
    private static func randomString(count: Int) -> String {
        var salt = String()
        
        while salt.count < count {
            let index = Int.random(in: 0...(standardChars.count-1))
            if index < standardChars.count - 1 {
                salt.append(standardChars[index])
            }
        }
        return salt
    }
    
}
