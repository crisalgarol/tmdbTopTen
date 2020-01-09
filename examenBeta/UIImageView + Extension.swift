//
//  UIImageView + Extension.swift
//  examenBeta
//
//  Created by Cristian Olmedo on 08/01/20.
//  Copyright © 2020 Cristian Olmedo. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func loadImageFromURL(url: String) {
        
        let imageURL = URL(string: url)!
        let cache = NSCache<AnyObject, AnyObject>()
        
        if let image = cache.object(forKey: url as AnyObject) as? UIImage {
            self.image = image
        }
        
        URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
                    
            if let error = error {
                print("Ocurrio un error \(error)")
                return
            }
            
            guard let data = data else {return}
            let downloadedImage = UIImage(data: data)!
            cache.setObject(downloadedImage, forKey: url as AnyObject)
            
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.8) {
                    self.alpha = 1.0
                }
                self.image = downloadedImage
            }
        }.resume()
        
    }
    
}
