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
    
    public init(name: String, key: String, keyboardType: KeyboardType, valueType: JEWFloatingTextFieldValueType) {
        self.name = name
        self.key = key
        self.keyboardType = keyboardType
        self.valueType = valueType
    }
    
}

public struct BFFTextFieldParser<Parseable: Decodable> {
    public static func create<Parseable: Decodable>(textFields: [JEWFloatingTextField], productTextFields: [BFFTextField], image: UIImage?, id:String? = nil, completionCallback: @escaping((Parseable?) -> ()))
    {
        var request = [String:Any]()
        var parseable: Parseable?
        for textField in textFields {
            if let productTextField = productTextFields.filter({$0.name == textField.placeHolderText}).first, textField.textFieldText != "" {
                let cleanText = textField.textFieldText.replacingOccurrences(of: "R$", with: "").replacingOccurrences(of: " ", with: "")
                request[productTextField.key] = cleanText
            }
        }
        
        do {
            let json = try JSONSerialization.data(withJSONObject: request)
            let decoder = JSONDecoder()
            parseable = try decoder.decode(Parseable.self, from: json) as Parseable
        } catch {
            print(error)
        }
        completionCallback(parseable)
    }
}
