//
//  UIImageView+JEWExtension.swift
//  JewFeatures
//
//  Created by Joao Gabriel Pereira on 17/04/20.
//

import Foundation

var imageCache = NSCache<AnyObject, AnyObject>()

public extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit, completionCallback: @escaping  (() -> ())) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    DispatchQueue.main.async {
                         self.image = UIImage(named: "noImage", in: JEWSession.bundle, compatibleWith: nil)
                        completionCallback()
                    }
                    return
                    
            }
            DispatchQueue.main.async() {
                self.image = image
                imageCache.setObject(image, forKey: url.absoluteString as AnyObject)
                completionCallback()
            }
        }.resume()
    }
    func downloaded(from link: String?, contentMode mode: UIView.ContentMode = .scaleAspectFit, completionCallback: @escaping  (() -> ())) {
        self.contentMode = mode
        
        if let cacheImage = imageCache.object(forKey: link as AnyObject) as? UIImage {
            DispatchQueue.main.async {
                self.image = cacheImage
                completionCallback()
            }
            return
        }
        
        guard let url = URL(string: link ?? String()) else {
            DispatchQueue.main.async {
                self.image = UIImage(named: "noImage", in: JEWSession.bundle, compatibleWith: nil)
                completionCallback()
            }
            return
        }
        downloaded(from: url, contentMode: mode, completionCallback: completionCallback)
    }
}
