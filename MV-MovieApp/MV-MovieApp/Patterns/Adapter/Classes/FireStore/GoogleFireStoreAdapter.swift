//
//  GoogleFireStoreAdapter.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 12.05.2022.
//

import Firebase
import FirebaseFirestore
import FirebaseDatabase
import FirebaseStorage

final class GoogleFireStoreAdapter {
    
    let ref: DatabaseReference
    
    init() {
        ref = Database.database().reference()
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
        self.ref
            .child("users")
            .child(userID)
            .setValue(userObject)
    }
    
    func readCurrentUser(completion: @escaping (Result<UserPresentation, Error>) -> Void) {
        let userID  = Auth.auth().currentUser!.uid

        ref.child("users/\(userID)").getData { error, snapshot in
            guard error == nil else { completion(.failure(error!)); return }
            
            let value = snapshot?.value as? NSDictionary
            let user  = UserPresentation(
                fullName: value?["fullName"] as? String ?? "",
                username: value?["username"] as? String ?? "",
                email: value?["email"] as? String ?? "",
                imageURL: value?["profilePic"] as? String ?? "",
                id: value?["id"] as? String ?? "")
            completion(.success(user))
        }
    }
    
    func updateUser(user: UserPresentation,
                    completion: @escaping (Result<UserPresentation, Error>) -> Void) {
        let userID  = Auth.auth().currentUser!.uid

        getUserProfilePicture { [self] url in
            let userObject = [
                "fullName": user.fullName ?? "",
                "username": user.username ?? "Anonymous",
                "email": user.email,
                "profilePic": url ?? user.imageURL,
                "id": userID
            ]
            
            self.ref.child("/users/\(userID)").setValue(userObject) { (error, _) in
                guard error == nil else { completion(.failure(error!)); return }
                self.readCurrentUser { (result) in
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
            case .success(let user):
               registeredUser.id != user.id ? completion(false) : completion(true)
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
