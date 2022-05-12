//
//  UIImageView+Ex.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 11.05.2022.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(with url: String) {
        guard let url = URL(string: url) else { return }
        
        self.kf
            .setImage(with: url,
                      placeholder: self.image,
                      options: [
                        .scaleFactor(UIScreen.main.scale),
                        .transition(.fade(1)),
                        .cacheOriginalImage
                      ]) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let retrieveResult): self.image = retrieveResult.image
            case .failure(_): break
            }
        }
    }
}
