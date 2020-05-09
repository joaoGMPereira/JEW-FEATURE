//
//  RSACrypto.swift
//  JewFeatures
//
//  Created by Joao Gabriel Pereira on 04/03/20.
//

import Foundation
import SwiftyRSA

public struct RSACrypto {
    public static func encrypt(publicKey: String, data: JSONAble) -> String? {
        if let base64String = dataToBase64(data: data), let encryptedString = encrypt(key: publicKey, string: base64String) {
            return encryptedString
        }
        return nil
    }
    
    private static func dataToBase64(data: JSONAble) -> String? {
        do {
            let objectData: Data = try JSONSerialization.data(withJSONObject:data.toDict(), options: JSONSerialization.WritingOptions.prettyPrinted)
            let stringBase64 = objectData.base64EncodedString()
            return stringBase64
        } catch let error {
            JEWLogger.error(error.localizedDescription)
            return nil
        }
    }
    
    private static func encrypt(key: String, string: String) -> String? {
        do {
            let publicKeyString = key.replacingOccurrences(of: "-----BEGIN PUBLIC KEY-----", with: "").replacingOccurrences(of: "-----END PUBLIC KEY-----", with: "").replacingOccurrences(of: "\n", with: "")
            
            let publicKey = try PublicKey.init(base64Encoded: publicKeyString)
            
            let clear = try ClearMessage(base64Encoded: string)
            let encrypted = try clear.encrypted(with: publicKey, padding: .PKCS1)
            return encrypted.base64String
        } catch let error {
            JEWLogger.error(error.localizedDescription)
            return nil
        }
    }
}
