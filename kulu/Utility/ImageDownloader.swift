//
//  ImageDownloader.swift
//  kulu
//
//  Created by Deepak Goyal on 09/06/26.
//

import UIKit

extension UIImageView{
    
    func load(fromURL url: String?){
        
        guard let url else { return }
        
        if let image = ImageCache.getImage(forKey: url as NSString){
            self.image = image
            return
        }
        
        guard let _url = URL(string: url) else { return }

        HttpService.shared.send(url: _url) { data, response, error in
            
            if let error{
                debugPrint(error.localizedDescription)
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                
                guard let self, let data, let image = UIImage(data: data) else {
                    return
                }
                
                self.image = image
                ImageCache.setImage(forKey: url as NSString, image: image)
            }
            
        }
        
    }
}
