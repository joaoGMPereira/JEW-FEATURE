//
//  BFFTextfields.swift
//  JewFeatures
//
//  Created by Joao Gabriel Pereira on 24/04/20.
//

import Foundation

public enum KeyboardType: Int, Decodable {
    case `default`, number
    public func getKeyboardType() -> UIKeyboardType {
        switch self {
        case .default:
            return .default
        case .number:
            return .decimalPad
        }
        
    }
}


public struct BFFTextField: Decodable {
    public let name: String
    public let key: String
    public let keyboardType: KeyboardType
    public var value: String = String()
    public var valueType: JEWFloatingTextFieldValueType
    public var isRequired: Bool
    
    public init(name: String, key: String, keyboardType: KeyboardType, valueType: JEWFloatingTextFieldValueType, isRequired: Bool = true) {
        self.name = name
        self.key = key
        self.keyboardType = keyboardType
        self.valueType = valueType
        self.isRequired = isRequired
    }
    
}

public struct BFFTextFieldParser<Parseable: Decodable> {
    public static func create<Parseable: Decodable>(textFields: [JEWFloatingTextField], productTextFields: [BFFTextField], completionCallback: @escaping((Parseable?, [JEWFloatingTextField]) -> ())) {
        var request = [String:Any]()
        var textFieldsError = [JEWFloatingTextField]()
        for textField in textFields {
            if let productTextField = productTextFields.filter({$0.name == textField.placeHolderText}).first, textField.textFieldText.isEmpty == false {
                request[productTextField.key] = textField.textFieldText
                if productTextField.valueType != JEWFloatingTextFieldValueType.none {
                    let cleanText = textField.textFieldText.replacingOccurrences(of: "R$", with: "").replacingOccurrences(of: " ", with: "")
                    request[productTextField.key] = cleanText
                }
            } else {
                if let productTextField = productTextFields.filter({$0.name == textField.placeHolderText}).first, productTextField.isRequired {
                    textFieldsError.append(textField)
                }
            }
        }
        parse(request: request, textFieldsError: textFieldsError, completionCallback: completionCallback)
    }
    
    private static func parse<Parseable: Decodable>(request: [String:Any], textFieldsError : [JEWFloatingTextField], completionCallback: @escaping((Parseable?, [JEWFloatingTextField]) -> ())) {
        var parseable: Parseable?
        do {
            let json = try JSONSerialization.data(withJSONObject: request)
            let decoder = JSONDecoder()
            parseable = try decoder.decode(Parseable.self, from: json) as Parseable
        } catch {
            JEWLogger.error(error)
        }
        completionCallback(parseable, textFieldsError)
    }
}
