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
    
    public static func jsonDict<T: Encodable>(_ value: T) -> [String: Any]? {
        do {
             guard let data = try JSONConverter.encode(value) else {
                return nil
             }
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                return json
            }
            return nil
        } catch {
           return nil
        }
    }
    
    public static func jsonArray<T: Encodable>(_ value: T) -> [[String: Any]]? {
        
        do {
             guard let data = try JSONConverter.encode(value) else {
                return nil
             }
            if let arrayJson = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                return arrayJson
            }
            return nil
        } catch {
           return nil
        }
    }
    
    public static func object<T: Decodable>(any: Any) -> T? {
        let data = (try? JSONSerialization.data(withJSONObject: any, options: [])) ?? Data()
        let decoded = try? JSONDecoder().decode(T.self, from: data)
        return decoded as T?
    }
}
