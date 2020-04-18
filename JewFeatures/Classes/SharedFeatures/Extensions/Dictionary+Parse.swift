//
//  Dictionary+Parse.swift
//  abseil
//
//  Created by Joao Gabriel Pereira on 16/04/20.
//

import Foundation


extension Dictionary {
    public func parseTo<T: Decodable>(responseClass: T.Type, successCompletion: @escaping(SuccessResponse), errorCompletion: @escaping(String) -> ()) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: [])
            let decodable = try JSONDecoder().decode(T.self, from: jsonData)
            JEWLogger.info(self, customInfo:"\(responseClass)")
            successCompletion(decodable)
        } catch let error {
            JEWLogger.error(error)
            errorCompletion("Alguns dados não foram possíveis serem mostrados")
        }
    }
}
