//
//  Dictionary+Parse.swift
//  abseil
//
//  Created by Joao Gabriel Pereira on 16/04/20.
//

import Foundation


extension Dictionary {
    public func parseTo<T: Decodable>(successCompletion: @escaping((T) -> ()), errorCompletion: @escaping(Error) -> ()) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: [])
            let decodable = try JSONDecoder().decode(T.self, from: jsonData)
            successCompletion(decodable)
        } catch let error {
            errorCompletion(error)
        }
    }
}
