//
//  RegistrationView.swift
//  iBartender
//
//  Created by Amin Carbonell on 11/9/24.
//
import SwiftUI
import FirebaseAuth

struct RegistrationView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var errorMessage: String?
    @State private var isRegistered = false  // State variable for navigation

    var body: some View {
        VStack(spacing: 20) {
            Text("Register")
                .font(.largeTitle)
                .padding(.bottom, 20)

            // Email field
            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)

            // Password field
            SecureField("Password", text: $password)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)

            // Confirm password field
            SecureField("Confirm Password", text: $confirmPassword)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)

            // Sign Up Button
            Button(action: registerUser) {
                Text("Sign Up")
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
        .navigationBarTitle("Sign Up", displayMode: .inline)
        // Navigation destination to LandingPage
        .navigationDestination(isPresented: $isRegistered) {
            CocktailFeedView()
        }
    }

    // Function to handle user registration
    private func registerUser() {
        guard password == confirmPassword else {
            errorMessage = "Passwords do not match."
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                errorMessage = error.localizedDescription
            } else {
                isRegistered = true  // Set to true upon successful registration
                errorMessage = nil
                print("User registered successfully")
            }
        }
    }
}

#Preview {
    RegistrationView()
}
