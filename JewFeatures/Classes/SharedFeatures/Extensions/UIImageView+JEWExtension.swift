//
//  UIImageView+JEWExtension.swift
//  JewFeatures
//
//  Created by Joao Gabriel Pereira on 17/04/20.
//

import Foundation

public extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit, completionCallback: @escaping  (() -> ())) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    DispatchQueue.main.async {
                        self.image = UIImage(named: "noImage")
                        completionCallback()
                    }
                    return
                    
            }
            DispatchQueue.main.async() {
                self.image = image
                completionCallback()
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit, completionCallback: @escaping  (() -> ())) {
        self.contentMode = mode
        guard let url = URL(string: link) else {
            self.image = UIImage(named: "noImage")
            completionCallback()
            return
        }
        downloaded(from: url, contentMode: mode, completionCallback: completionCallback)
    }
}
