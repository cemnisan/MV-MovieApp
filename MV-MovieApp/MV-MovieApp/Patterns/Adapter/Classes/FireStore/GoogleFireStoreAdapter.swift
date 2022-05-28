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
        if let userID = Auth.auth().currentUser?.uid {
            do {
                try db
                    .collection(K.Firebase.userCollection)
                    .document(userID)
                    .setData(from: user)
            } catch {
                fatalError("Something went wrong: \(error)")
            }
        }
    }
    
    func readUser(completion: @escaping (Result<UserPresentation, Error>) -> Void) {
        if let userID  = Auth.auth().currentUser?.uid {
            let docRef = db.collection(K.Firebase.userCollection).document(userID)
            docRef.getDocument(as: UserPresentation.self) { result in
                switch result {
                case .success(let user):
                    completion(.success(user))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func updateUser(
        with fullName: String?,
        username: String?,
        profilePic: String?,
        backgroundPic: String?,
        completion: @escaping (Result<UserPresentation, Error>) -> Void)
    {
        if let userID  = Auth.auth().currentUser?.uid {
            let docRef = db.collection(K.Firebase.userCollection).document(userID)
            let userObject: [AnyHashable: Any] = [
                "fullName": fullName,
                "username": username,
                "profilePic": profilePic,
                "backgroundPic": backgroundPic
            ].compactMapValues { $0 }
            
            docRef.updateData(userObject) { [weak self] error in
                guard let self = self,
                      error == nil else { completion(.failure(error!)); return }
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
    
    func saveLoggedInUserIfNeeded(loggedInUser: UserPresentation) {
        let docRef = db
            .collection(K.Firebase.userCollection)
            .whereField(K.Firebase.idField, isEqualTo: loggedInUser.id)
        docRef.getDocuments { [weak self] (snapshot, error) in
            guard let self = self,
                  error == nil,
                  snapshot?.documents.count == 0 else { return }
            self.createUser(user: loggedInUser)
        }
    }
    
    func isUsernameAlreadyExist(username: String?,
                                completion: @escaping (Bool) -> Void) {
        guard let username = username else { completion(false); return }
        let docRef = db
            .collection(K.Firebase.userCollection)
            .whereField(K.Firebase.usernameField, isEqualTo: username)
        docRef.getDocuments { (snapshot, error) in
            guard error == nil else { return }
            
            if snapshot!.documents.count > 0 { completion(true) }
            else { completion(false) }
        }
    }
}
