//
//  Firebase-Extension.swift
//  MatchingApp
//
//  Created by Yong Jun Cha on 2021/03/17.
//

import Firebase

// MARK : -AUTH
extension Auth {
    static func createUserToFireAuth(email : String?, password: String?, name: String?, completion:          @escaping (Bool) -> Void) {
        guard let email = email else {return}
        guard let password = password else {return}
        Auth.auth().createUser(withEmail: email, password: password) { (auth, err) in
            if let err = err {
                print("AuthInfo Save Failed", err)
                return
            }
            guard let uid = auth?.user.uid else { return }
            Firestore.setUserDataToFirestore(email: email,uid: uid, name: name) { success in
                completion(success)
            }
        }
    }
    
    
    static func loginWithFireAuth(email : String, password : String, completion : @escaping (Bool) -> Void){
        
        Auth.auth().signIn(withEmail: email, password: password) { (res, err) in
            if let err = err {
                print("Login Failed : ", err)
                completion(false)
                return
            }
            print("Login Success")
            completion(true)
        }
    }
}

// MARK : -FIRESTORE
extension Firestore {
    
    static func setUserDataToFirestore(email : String,uid : String, name: String?, completion : @escaping (Bool) -> ()){
        guard let name = name else {return}
        let document = [
            "name" : name,
            "email" : email,
            "createdAt" : Timestamp()
        ] as [String : Any]
    
        
        Firestore.firestore().collection("users").document(uid).setData(document)
        { err in
            if let err = err{
                print("Register User Infromation Failed", err)
                return
            }
            completion(true)
            
            print("Register User Information Success")
        }
    }
    
    // Get Data From FireStore
    static func fetchUserFromFirestore(uid : String, completion : @escaping (User?) -> Void) {
        
        Firestore.firestore().collection("users").document(uid).getDocument { (snapshot, err) in
            
            if let err = err {
                print("Failed to get User Data")
                completion(nil)
                return
            }
            
            guard let dic = snapshot?.data() else { return }
            let user = User(dic: dic)
            completion(user)
    }
}
}
