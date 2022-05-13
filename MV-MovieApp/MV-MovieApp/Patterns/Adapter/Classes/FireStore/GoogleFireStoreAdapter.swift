//
//  GoogleFireStoreAdapter.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 12.05.2022.
//

import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage

final class GoogleFireStoreAdapter {
    
    let db: Firestore
    
    init() {
        db = Firestore.firestore()
    }
}

extension GoogleFireStoreAdapter: GoogleFireStoreService {
    
    func createUser(user: UserPresentation) {
        let userID  = Auth.auth().currentUser!.uid
        
        do {
            try db.collection("users").document(userID).setData(from: user)
        } catch {
            print("error")
        }
    }
    
    func readUser(completion: @escaping (Result<UserPresentation, Error>) -> Void) {
        let userID  = Auth.auth().currentUser!.uid
        let docRef  = db.collection("users").document(userID)
        
        docRef.getDocument(as: UserPresentation.self) { result in
            switch result {
            case .success(let user):
                completion(.success(user))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func updateUser(with fullName: String?,
                    username: String?,
                    profilePic: String?,
                    completion: @escaping (Result<UserPresentation, Error>) -> Void) {
        let userID  = Auth.auth().currentUser!.uid
        let docRef  = db.collection("users").document(userID)
        
        getUserProfilePicture { url in
            let userObject: [AnyHashable: Any] = [
                "fullName": fullName,
                "username": username,
                "profilePic": url ?? profilePic,
            ].compactMapValues { $0 }
 
            docRef.updateData(userObject) { [weak self] error in
                guard let self = self else { return }
                guard error == nil else { return }
                
                self.readUser { result in
                    switch result {
                    case .success(let user):
                        completion(.success(user))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }
        }
    }
    
    func isUserAlreadyExist(registeredUser: UserPresentation,
                            completion: @escaping (Bool) -> Void) {
        readUser { result in
            switch result {
            case .success(let currentUser):
                registeredUser.id == currentUser.id ? completion(true) : completion(false)
            case .failure(_): break
            }
        }
    }
    
    func isUsernameAlreadyExist(username: String?,
                                completion: @escaping (Bool) -> Void) {
        guard let username = username else { completion(false); return }

        let docRef = db.collection("users").whereField("username",
                                                       isEqualTo: username)
        docRef.getDocuments { (snapshot, error) in
            guard error == nil else { return }
            
            if snapshot!.documents.count > 0 { completion(true) }
            else { completion(false) }
        }
    }
    
    private func getUserProfilePicture(completion: @escaping (String?) -> Void)  {
        let userID  = Auth.auth().currentUser!.uid
        
        let imageName = String("\(userID).png")
        let storageRef = Storage
            .storage()
            .reference()
            .child("User")
            .child("profilePic")
            .child(imageName)
        storageRef.downloadURL { url, error in
            guard error == nil else { completion(nil); return }
            completion(url?.absoluteString)
        }
    }
}
