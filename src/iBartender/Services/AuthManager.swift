//
//  AuthManager.swift
//  iBartender
//
//  Created by Amin Carbonell on 11/9/24.
//

import Foundation
import FirebaseAuth

class AuthManager {
    
    // Singleton instance for easy access throughout the app (optional)
    static let shared = AuthManager()
    
    private init() {} // Private initializer to enforce singleton use

    // Sign up function
    func signUp(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }

    // Login function
    func login(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}
