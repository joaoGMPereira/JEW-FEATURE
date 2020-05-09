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
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit, completionCallback: @escaping  ((UIImage?, String) -> ())) {
        self.contentMode = mode
        
        if let cacheImage = imageCache.object(forKey: link as NSString)  {
            DispatchQueue.main.async {
               // self.image = cacheImage
                completionCallback(cacheImage, link)
            }
            return
        }
        
        guard let url = URL(string: link) else {
            DispatchQueue.main.async {
                let imageNotFound = UIImage(named: "noImage", in: JEWSession.bundle, compatibleWith: nil)
                //self.image = imageNotFound
                completionCallback(imageNotFound, link)
            }
            return
        }
        downloaded(from: url, contentMode: mode, completionCallback: completionCallback)
    }
    
    func getImageFromFileManager(urlString: String) {
        
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
        let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        if let dirPath          = paths.first
        {
           let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent(urlString)
           let image    = UIImage(contentsOfFile: imageURL.path)
            DispatchQueue.main.async {
                self.image = image
            }
           // Do whatever you want with the image
        }
    }
}
