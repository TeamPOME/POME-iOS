//
//  PomeMaskedImageView.swift
//  POME-iOS
//
//  Created by EUNJU on 2022/07/10.
//

import UIKit

class PomeMaskedImageView: UIImageView {
    
    // MARK: Properties
    private var maskImageView = UIImageView()
    
    var maskImage: UIImage? {
        didSet {
            maskImageView.image = maskImage
            updateImageView()
        }
    }
    
    // MARK: Life Cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        updateImageView()
    }
    
    /// 원본 이미지에 mask를 적용해주는 메서드
    private func updateImageView() {
        if maskImageView.image != nil {
            maskImageView.frame = bounds
            mask = maskImageView
        }
    }
}
