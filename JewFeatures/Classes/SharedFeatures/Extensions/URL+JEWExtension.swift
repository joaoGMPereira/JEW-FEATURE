//
//  Data+JEWExtension.swift
//  JewFeatures
//
//  Created by Joao Gabriel Medeiros Perei on 26/11/19.
//

import Foundation
import UIKit

public typealias DownloadSuccess = ((_ image: UIImage) -> Void)
public typealias DownloadError = ((_ errorMessage: String) -> Void)

extension URL {
    
    public func downloadImage(success: @escaping DownloadSuccess, failure: @escaping DownloadError) {
        JEWLogger.info("Download Started")
        getData(from: self) { data, response, error in
            guard let data = data, error == nil else { return }
            JEWLogger.info(response?.suggestedFilename ?? self.lastPathComponent)
            JEWLogger.info("Download Finished")
            DispatchQueue.main.async() {
                guard let image = UIImage(data: data) else {
                    failure("Falha no Download")
                    return
                }
                success(image)
            }
        }
    }
    
    public func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
