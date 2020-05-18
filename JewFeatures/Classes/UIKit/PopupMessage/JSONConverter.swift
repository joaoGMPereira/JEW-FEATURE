//
//  JSONConverter.swift
//  JewFeatures
//
//  Created by Joao Gabriel Pereira on 18/05/20.
//

import Foundation

public struct JSONConverter {
   public static func decode<T: Decodable>(_ data: Data) throws -> [T]? {
   do {
         let decoded = try JSONDecoder().decode([T].self, from: data)
         return decoded
      } catch {
         throw error
      }
   }
    
    public static func encode<T: Encodable>(_ value: T) throws -> Data? {
       do {
          let data = try JSONEncoder().encode(value)
          return data
       } catch {
          throw error
       }
    }
    
    public static func json<T: Encodable>(_ value: T, completion:(([String: Any]?, [[String: Any]]?) -> ())) {
        do {
             guard let data = try JSONConverter.encode(value) else {
                completion(nil, nil)
                return
             }
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                completion(json, nil)
                return
            }
            
            if let arrayJson = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                completion(nil, arrayJson)
                return
            }
            
            completion(nil, nil)
        } catch {
           completion(nil, nil)
        }
    }
}
