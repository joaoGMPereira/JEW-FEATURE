//
//  INVSTextFieldFormat.swift
//  InvestEx_Example
//
//  Created by Joao Medeiros Pereira on 12/05/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

public extension String {
    
    
    private enum Constants {
        static let kPrefixUnicode = "U+"
        static let kPrefixHex = "0x"
        static let kRadix = 16
        static let dayRegexPattern = "[0-9]{2}$"
        static let monthRegexPattern = "(?<=-)[0-9]{2}(?=-)"
        static let yearRegexPattern = "^[0-9]{4}"
    }
    
    private enum Strings: String {
        case localizableAccessibilityValue = "LocalizableAccessibilityValue"
        case localizableAccessibilityIdentifiers = "LocalizableAccessibilityIdentifiers"
        case localizable = "Localizable"
    }
    
    /// Imagem formatada para exibição
    internal var unicode: String {
        let stringWithoutUnicodePrefix = replacingOccurrences(of: Constants.kPrefixUnicode, with: String())
        guard let unicodeValue = Int(stringWithoutUnicodePrefix, radix: Constants.kRadix) else { return String() }
        return String(UnicodeScalar(unicodeValue) ?? UnicodeScalar(0))
    }
    
    /// Adiciona um observer de notificação.
    ///
    /// - Parameters:
    ///   - target: Target do observer.
    ///   - selector: Selector chamado pelo observer.
    func attachNotificationListener(target: Any, selector: Selector) {
        NotificationCenter.default.addObserver(target, selector: selector, name: Notification.Name(self), object: nil)
    }
    /// Adiciona um regex na string que só deixa numero e limitar o tamanho dela
    ///
    /// - Parameters:
    ///   - target: size da string
    ///   - selector: Selector chamado pelo observer.
    func stringOfNumbersRegex(with size:Int? = nil) -> String {
        var amountWithPrefix = self
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = String(regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "").prefix(size ?? self.count))
        return amountWithPrefix
    }
    
    func accountFormat() -> String {
        
        var accountJustNumbers = self
        
        // remove from String: "$", ".", ","
        accountJustNumbers = stringOfNumbersRegex(with: 6)
        var formattedAccount = accountJustNumbers
        if accountJustNumbers.count == 6 {
            let lastNumber = String(formattedAccount.last ?? Character(""))
            formattedAccount =  "\(formattedAccount.dropLast())-" + lastNumber
            
        }
        
        return formattedAccount
    }
    
    func getAbbreviationName() -> String {
        var abbreviationName = String()

        let names = self.split(separator: " ")
        if let firstLetter = names.first?.first {
            abbreviationName.append(firstLetter)
        }
        if names.count > 1 , let secondLetter = names[1].first {
            abbreviationName.append(secondLetter)
        }
        return abbreviationName.uppercased()
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
    
    // formatting text for currency textField
    func percentFormat(backSpace: Bool = false) -> String {
        var number: NSNumber!
        let formatter = NumberFormatter.currencyDefault()
        formatter.numberStyle = .currencyAccounting
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        var amountWithoutPrefix = self
        
        // remove from String: "$", ".", ","
        amountWithoutPrefix = stringOfNumbersRegex(with: 5)
        if backSpace {
            amountWithoutPrefix = String(amountWithoutPrefix.prefix(amountWithoutPrefix.count - 1))
        }
        let double = (amountWithoutPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))
        
        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return ""
        }
        let stringWithSymbol = formatter.string(from: number)!
        return stringWithSymbol.addPercentSymbol()
    }
    
    private func addPercentSymbol() -> String {
        let stringWithSymbol = "\(self.replacingOccurrences(of: "R$", with: ""))%"
        return stringWithSymbol
    }
    
    func currencyFormat(backSpace: Bool = false) -> String {
        
        var number: NSNumber!
        let formatter = NumberFormatter.currencyDefault()
        
        var amountWithoutPrefix = self
        
        // remove from String: "$", ".", ","
        amountWithoutPrefix = stringOfNumbersRegex(with: 10)
        
        let double = (amountWithoutPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))
        
        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            if backSpace {
                return ""
            }
            return "0"
        }
        
        return formatter.string(from: number)!
    }
    
    func monthFormat() -> String {
        
        var amountWithoutPrefix = self
        
        // remove from String: "$", ".", ","
        amountWithoutPrefix = stringOfNumbersRegex(with: 3)
        
        return amountWithoutPrefix
    }
    
    func convertToInt() -> Int {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt_BR") // USA:
        formatter.numberStyle = .decimal
        let number = formatter.number(from: self)
        return number?.intValue ?? 0
    }
    
    func convertToDouble() -> Double? {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt_BR") // USA:
        formatter.numberStyle = .decimal
        let number = formatter.number(from: self)
        return number?.doubleValue
    }
    
    func convertToFloat() -> Float? {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt_BR") // USA:
        formatter.numberStyle = .decimal
        let number = formatter.number(from: self)
        return number?.floatValue
    }
    
    func checkSignal() -> String {
        if self != "" {
            if self.first == "-" {
                return "-"
            }
            return "+"
        }
        return "+"
    }
    
    func isValidEmail() -> Bool {
        let regex: String
        regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self)
    }
    
    func getInDefaults<T: Decodable>(completion: @escaping ((T?) -> ())) {
        if let codable = UserDefaults.standard.object(forKey: self) as? Data {
            let decoder = JSONDecoder()
            if let decodable = try? decoder.decode(T.self, from: codable) {
                completion(decodable)
            }
            return
        }
        completion(nil)
    }
    
    
    func downloaded(completionCallback: @escaping  ((UIImage?, String) -> ())) {
        
        if let cacheImage = imageCache.object(forKey: self as NSString)  {
            DispatchQueue.main.async {
               // self.image = cacheImage
                completionCallback(cacheImage, self)
            }
            return
        }
        
        guard let url = URL(string: self) else {
            DispatchQueue.main.async {
                let imageNotFound = UIImage(named: "noImage", in: JEWSession.bundle, compatibleWith: nil)
                //self.image = imageNotFound
                completionCallback(imageNotFound, self)
            }
            return
        }
        downloaded(with: url, completionCallback: completionCallback)
    }
    
    private func downloaded(with url: URL, completionCallback: @escaping  ((UIImage?, String) -> ())) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    DispatchQueue.main.async {
                        let imageNotFound = UIImage(named: "noImage", in: JEWSession.bundle, compatibleWith: nil)
                        // self.image = imageNotFound
                        completionCallback(imageNotFound, url.absoluteString)
                    }
                    return
                    
            }
            DispatchQueue.main.async() {
               // self.image = image
                imageCache.setObject(image, forKey: url.absoluteString as NSString)
                completionCallback(image, url.absoluteString)
            }
        }.resume()
    }
    
    func getImageFromFileManager(completion: @escaping ((UIImage?) -> ())) {
        
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
        let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        if let dirPath          = paths.first
        {
           let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent(self)
           let image    = UIImage(contentsOfFile: imageURL.path)
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
}
