//
//  GoogleStorageAdapter.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 11.05.2022.
//

import Firebase
import FirebaseStorage

final class GoogleStorageAdapter {
    init() {}
}

// MARK: - Upload Service
extension GoogleStorageAdapter: UploadMediaService {
    
    func uploadMedia(with imageData: Data,
                     progress: @escaping (_ progress: Float?) -> Void,
                     completion: @escaping (_ url: URL?) -> Void) {
        let imageName = String("\(Auth.auth().currentUser!.uid).png")
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        
        let storageRef = Storage
            .storage()
            .reference()
            .child("User")
            .child("profilePic")
            .child(imageName)
        
        let uploadTask = storageRef.putData(imageData, metadata: metaData) { (_, error) in
            guard error == nil else { completion(nil); return }
            
            storageRef.downloadURL { url, error in
                guard error == nil else { completion(nil); return }
                completion(url)
            }
        }
        
        uploadTask.observe(.progress) { snapshot in
            progress(Float(snapshot.progress?.fractionCompleted ?? 0) * 100)
            
            if snapshot.status == .success || snapshot.status == .failure {
                uploadTask.removeAllObservers(for: .progress)
                progress(nil)
            }
        }
    }
}