//
//  UploadMedia.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 11.05.2022.
//

import Foundation

protocol UploadMediaService {
    func uploadMedia(with pictureData: Data,
                     selectedPicker: SelectPickerView,
                     progress: @escaping (_ progress: Float?) -> Void,
                     completion: @escaping (_ url: URL?) -> Void)
}
