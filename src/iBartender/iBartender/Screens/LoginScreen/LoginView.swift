//
//  LoginView.swift
//  iBartender
//
//  Created by Amin Carbonell on 11/9/24.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String?
    @State private var isLoggedIn = false  // State variable for navigation
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Login")
                .font(.largeTitle)
                .padding(.bottom, 20)
            
            // Email Text Field
            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)
            
            // Password Secure Field
            SecureField("Password", text: $password)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)
            
            // Login Button
            Button(action: loginUser) {
                Text("Login")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.top, 20)
            
            // Display any error message
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding()
            }
        }
        .padding()
        .navigationBarTitle("Login", displayMode: .inline)
        // Navigation destination to LandingPage
        .navigationDestination(isPresented: $isLoggedIn) {
            LandingPageView()
        }
    }
    
    // Function to handle user login
    private func loginUser() {
        AuthManager.shared.login(email: email, password: password) { result in
            switch result {
            case .success:
                isLoggedIn = true  // Navigate on successful login
                errorMessage = nil
            case .failure(let error):
                errorMessage = error.localizedDescription
            }
        }
    }
}

#Preview {
    LoginView()
}

