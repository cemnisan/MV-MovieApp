//
//  GoogleFireStoreAdapter.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 12.05.2022.
//

import Firebase
import FirebaseFirestore
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
        
        let userObject = [
            "fullName": user.fullName ?? "",
            "username": user.username ?? "Anonymous",
            "email": user.email,
            "profilePic": user.imageURL ?? "",
            "id": userID
        ]
        
        db.collection("users")
            .document(userID)
            .setData(userObject) { error in
                guard error == nil else { return }
            }
    }
    
    func readCurrentUser(completion: @escaping (Result<UserPresentation, Error>) -> Void) {
        let userID  = Auth.auth().currentUser!.uid
        let docRef  = db.collection("users").document(userID)
        
        docRef.getDocument { document, error in
            if let document = document, document.exists {
                let dataDescription = document.data()
                let user  = UserPresentation(
                    fullName: dataDescription?["fullName"] as? String ?? "",
                    username: dataDescription?["username"] as? String ?? "",
                    email: dataDescription?["email"] as? String ?? "",
                    imageURL: dataDescription?["profilePic"] as? String ?? "",
                    id: dataDescription?["id"] as? String ?? "")
                completion(.success(user))
            } else {
                completion(.failure(error!))
            }
        }
    }
    
    func updateUser(user: UserPresentation,
                    completion: @escaping (Result<UserPresentation, Error>) -> Void) {
        let userID  = Auth.auth().currentUser!.uid
        let docRef  = db.collection("users").document(userID)
        
        getUserProfilePicture { url in
            let userObject = [
                "fullName": user.fullName ?? "",
                "username": user.username ?? "Anonymous",
                "email": user.email,
                "profilePic": url ?? user.imageURL,
                "id": userID
            ] as! [AnyHashable : Any]
            
            docRef.updateData(userObject) { [weak self] error in
                guard let self = self else { return }
                guard error == nil else { completion(.failure(error!)); return }
                
                self.readCurrentUser { result in
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
        readCurrentUser { result in
            switch result {
            case .success(let currentUser):
                registeredUser.id == currentUser.id ? completion(true) : completion(false)
            case .failure(_): break
            }
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
