//
//  UIImageView+JEWExtension.swift
//  JewFeatures
//
//  Created by Joao Gabriel Pereira on 17/04/20.
//

import Foundation

var imageCache = NSCache<NSString, UIImage>()

public extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit, completionCallback: @escaping  ((UIImage?, String) -> ())) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    DispatchQueue.main.async {
                        completionCallback(nil, url.absoluteString)
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
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit, completionCallback: @escaping  ((UIImage?, String) -> ())) {
        DispatchQueue.main.async {
            self.contentMode = mode
        }
        
        if let cacheImage = imageCache.object(forKey: link as NSString)  {
            DispatchQueue.main.async {
                completionCallback(cacheImage, link)
            }
            return
        }
        
        guard let url = URL(string: link) else {
            DispatchQueue.main.async {
                completionCallback(nil, link)
            }
            return
        }
        downloaded(from: url, contentMode: mode, completionCallback: completionCallback)
    }
}
