//
//  UIImageView+.swift
//  POME-iOS
//
//  Created by 한유진 on 2022/07/20.
//

import Foundation
import UIKit

extension UIImageView {
    
   func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
      URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
   }
    
    /// 이미지 url을 다운 받아주는 하수
   func downloadImage(from url: URL) {
      getData(from: url) {
         data, response, error in
         guard let data = data, error == nil else {
            return
         }
         DispatchQueue.main.async() {
            self.image = UIImage(data: data)
         }
      }
   }
}
