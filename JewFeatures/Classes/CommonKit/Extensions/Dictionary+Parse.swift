//
//  Dictionary+Parse.swift
//  abseil
//
//  Created by Joao Gabriel Pereira on 16/04/20.
//

import Foundation


extension Dictionary {
    public func parseTo<T: Decodable>(successCompletion: @escaping((T) -> ()), errorCompletion: @escaping(String) -> ()) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: [])
            let decodable = try JSONDecoder().decode(T.self, from: jsonData)
            JEWLogger.info(self, customInfo:"\(T.self)")
            successCompletion(decodable)
        } catch let error {
            JEWLogger.error(error)
            errorCompletion("Alguns dados não foram possíveis serem mostrados")
        }
    }
}
