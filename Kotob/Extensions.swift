//
//  File.swift
//  myMessenger
//
//  Created by Ahmed Mokhtar on 7/15/18.
//  Copyright © 2018 Ahmed Mokhtar. All rights reserved.
//

import UIKit


extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat){
        self.init(red: r / 255, green: g / 255, blue: b / 255, alpha: 1)
    }
    
    static var nagwaOrange = UIColor(r: 255, g: 122, b: 79)
}


extension UIApplication {
    static func mainTabBarController() -> MainTabBarController? {
        
        return shared.keyWindow?.rootViewController as? MainTabBarController
    }
}



extension UIFont {
    class var textStyle: UIFont {
        return UIFont(name: "DroidArabicNaskh-Bold", size: 13.0)!
    }
    class var textStyle2: UIFont {
        return UIFont(name: "DroidArabicNaskh-Bold", size: 13.0)!
    }
}


let imageCache = NSCache<NSURL, UIImage>()

extension UIImageView {
    
    func getImageWithURL(url : NSURL) {
        
        if let cachedImage = imageCache.object(forKey: url) {
            self.image = cachedImage
            return
        }
        
        self.image = nil
        
        let session = URLSession.shared.dataTask(with: url as URL) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            guard let data = data else { return }
            if let downloadedImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = downloadedImage
                }
                imageCache.setObject(downloadedImage, forKey: url)
            }
        }
        session.resume()
    }
}


extension String {
    func toSecureHTTPS() -> String {
        return self.contains("https") ? self : self.replacingOccurrences(of: "http", with: "https")
    }
}




extension UIView {
    
    func setupXYAnchors (top : NSLayoutYAxisAnchor? = nil,
                      bottom : NSLayoutYAxisAnchor? = nil,
                      leading : NSLayoutXAxisAnchor? = nil,
                      trailing : NSLayoutXAxisAnchor? = nil,
                      centerX : NSLayoutXAxisAnchor? = nil,
                      centerY : NSLayoutYAxisAnchor? = nil,

                      topConstant : CGFloat = 0,
                      bottomConstant : CGFloat = 0,
                      leadingConstant : CGFloat = 0,
                      trailingConstant : CGFloat = 0,
                      centerXConstant : CGFloat = 0,
                      centerYConstant : CGFloat = 0) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: topConstant).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: bottomConstant).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: leadingConstant).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: trailingConstant).isActive = true
        }
        
        
        
        if let centerX = centerX {
            centerXAnchor.constraint(equalTo: centerX, constant: centerXConstant).isActive = true
        }
        
        if let centerY = centerY {
            centerYAnchor.constraint(equalTo: centerY, constant: centerYConstant).isActive = true
        }

    }
    
    
    
    func setUpDimensionsAnchors (width : NSLayoutDimension?,
                          height : NSLayoutDimension?,
                          for widthConstant : CGFloat = 0,
                          for widthMultiplier : CGFloat = 1 ,
                          for heightConstant : CGFloat = 0,
                          for heightMultiplier : CGFloat = 1) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let height = height {
            heightAnchor.constraint(equalTo: height, multiplier: heightMultiplier, constant: heightConstant).isActive = true
        } else {
            heightAnchor.constraint(equalToConstant: heightConstant).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalTo: width, multiplier: widthMultiplier, constant: widthConstant).isActive = true
        } else {
            widthAnchor.constraint(equalToConstant: widthConstant).isActive = true
        }
    }
    
}

