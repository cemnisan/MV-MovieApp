//
//  UploadMedia.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 11.05.2022.
//

import Foundation

protocol UploadMediaService {
    func uploadMedia(with imageData: Data,
                     completion: @escaping (_ url: URL?) -> Void)
}
