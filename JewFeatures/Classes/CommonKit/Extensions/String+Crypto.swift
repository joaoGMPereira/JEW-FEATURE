//
//  String+Crypto.swift
//  JewFeatures
//
//  Created by Joao Gabriel Pereira on 21/04/20.
//

import Foundation
import CommonCrypto

extension String {
    
    public var length: Int {
        return count
    }
    
    public subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    
    public func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }
    
    public func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }
    
    public subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    
    public var hexToStr: String {
        let regex = try! NSRegularExpression(pattern: "(0x)?([0-9A-Fa-f]{2})", options: .caseInsensitive)
        let textNS = self as NSString
        let matchesArray = regex.matches(in: textNS as String, options: [], range: NSMakeRange(0, textNS.length))
        let characters = matchesArray.map {
            Character(UnicodeScalar(UInt32(textNS.substring(with: $0.range(at: 2)), radix: 16)!)!)
        }
        return String(characters)
    }
    
    public func randomData() -> Data {
        let data = Data(self.utf8)
        return data
    }
}


extension String {
    
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
        let standardChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890"
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
